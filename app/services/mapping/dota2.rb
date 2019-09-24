# 1. 从 DB 里面拿     Live 的数据
# 2. 从 Redis 里面拿  Live 的数据
module Mapping
  class Dota2

    attr_accessor :db_names, :db_ids, :redis_names, :redis_ids

    def initialize
      @db_names = Hash.new
      @db_ids   = Hash.new
      @redis_names = Hash.new
      @redis_ids   = Hash.new
    end

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