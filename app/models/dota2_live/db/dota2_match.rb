# 更新dota2_match table的入口
#
module Dota2Live
  module Db
    module Dota2Match

      include Getter
      include LiveData
      include Validator
      include ClientData

      def update_db_match(match)
        if load_series(match).nil?
          puts "series not found for [RADIANT] #{radiant_team_name(match)} [DIRE] #{dire_team_name(match)}"
          return
        end
        update_series(match)
        if load_match(match).nil?
          puts "match not found for #{radiant_team_name(match)} #{dire_team_name(match)} series: #{@series} game_no: #{game_no(match)}"
          return
        end
        load_redis_match(match)
        update_match(match)
      end

      private
      def update_series(match)
        @series.update(live: true)   # => 启动live模式
        @series.update(status: 'ongoing') unless @series.status == 'finished' # => 只有在状态不为结束时更新为进行中
      end

      def load_redis_match(match)
        @live_match = LiveMatch.find(match_id: match['match_id']).first
        @live_match_log = LiveMatchLog.find(match_id: match['match_id']).first
      end

      def load_series(match)
        radiant_team = radiant_team(match)
        dire_team = dire_team(match)
        if radiant_team && dire_team
          @series = MatchSeries.find_with_teams(radiant_team.id, dire_team.id)
          return nil if @series.nil? || start_time_wrong?
        else
          return nil
        end
        true
      end

      def load_match(match)
        @match = @series.matches.find_by(game_no: @series.next_game_no)
      end

      def update_match(match)
        return unless @match.left_team_win.nil?

        if normal?(match)
          update_live_data(match_params(match))
          update_client_data(true)
        elsif reverse?(match)
          update_live_data(reversed_match_params(match))
          update_client_data(false)
        end
      end

    end
  end
end
