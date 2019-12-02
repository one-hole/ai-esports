# encoding: utf-8

module Live
  module Leagues
    class Exec

      extend BattleActions

      def self.start
        @redis = Redis.new
        resp = Request.run
        begin
          battles = JSON.parse(resp.body, allow_nan: true)["result"]["games"]
          # battles = ActiveSupport::JSON.decode(resp.body)["result"]["games"]
          process(battles.select { |battle| valid?(battle) })
        rescue => e
          puts e
        end
      end

      def self.process(battles)
        battles.each { |battle| process_battle(battle) }
      end

      def self.valid?(game)
        return false if (game['radiant_team'].nil? || game['dire_team'].nil?) # => 天辉夜魇队伍名称及ID
        return false if game['scoreboard'].nil?                               # => 计分板信息
        return false if game['scoreboard']['radiant'].nil?                    # => 天辉数据
        return false if game['scoreboard']['dire'].nil?                       # => 夜魇数据
        # return false if game['scoreboard']['radiant']['picks'].nil?           # => 天辉pick
        # return false if game['scoreboard']['dire']['picks'].nil?              # => 夜魇pick
        # return false if game['scoreboard']['radiant']['bans'].nil?            # => 天辉ban
        # return false if game['scoreboard']['dire']['bans'].nil?               # => 夜魇ban
        return true
      end
    end
  end
end

# Live::Leagues::Exec.start
#
#
# 1. 如果是这边创建的
# 2. 如果不是这边创建的
