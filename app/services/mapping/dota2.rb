# 1. 从 DB 里面拿     Live 的数据
# 2. 从 Redis 里面拿  Live 的数据
# 3. 先找 TeamID 有没有已经 Map 上的
# 4. 然后 找 Name 有没有能 Map 上的
module Mapping
  class Dota2

    attr_accessor :db_names, :db_ids, :redis_names, :redis_ids

    def initialize
      @db_names = Hash.new
      @db_ids   = Hash.new
      @redis_names = Hash.new
      @redis_ids   = Hash.new
      @redis = Redis.new(db: 12)

      load_from_db
      load_from_redis
    end

    def run
      mapping_ids
    end

    # 如果 ID 已经匹配上, 那么从 @match_series 和 @live_battles 里面剔出 对应的
    # 这里 要设置 Redis 里面的值
    def mapping_ids
      @redis_ids.each do |redis_key, redis_value|
        @db_ids.each do |db_key, db_value|
          if be_included?(redis_value, db_value)
            battle = Live::Battle[redis_key]
            battle.db_id = db_key
            battle.save

            @redis.publish("aiesports-dota2-websocket-v2", battle.info.to_json)
          end
        end
      end
    end

    # target 是 redis
    def be_included?(target, source)
      target.each do |item|
        return true if source.include?(item.to_i)
      end
      return false
    end

    def mapping_names
    end

    # private
    
    def load_from_db
      @match_series = Dota2Series.includes(:left_team, :right_team).where(status: 1)
      @match_series.each do |s|
        @db_names[s.id] = s.names
        @db_ids[s.id]   = s.ids
      end
      return nil
    end

    def load_from_redis
      @live_battles = Live::Battle.all
      @live_battles.each do |b|
        @redis_names[b.id] = b.teams
        @redis_ids[b.id]   = b.team_steam_ids
      end
    end
  end
end