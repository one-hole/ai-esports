# 队伍相关信息
#
module Dota2Live
  module MatchLog
    module Team
      # ---------------------------------------------------------------
      # 经济经验
      # ---------------------------------------------------------------
      def update_team_info(log, players, is_radiant, duration)
        net_worth = 0
        xp = 0

        players.each do |player|
          net_worth += player['net_worth'].to_i
          xp += (duration / 60) * player['xp_per_min'].to_i
        end

        if is_radiant
          unless net_worth == 0
            radiant_gold = JSON.parse(log.radiant_gold)
            radiant_gold << net_worth
            log.radiant_gold = radiant_gold.to_json
          end
          unless xp == 0
            radiant_xp = JSON.parse(log.radiant_xp)
            radiant_xp << xp
            log.radiant_xp = radiant_xp.to_json
          end
        else
          unless net_worth == 0
            dire_gold = JSON.parse(log.dire_gold)
            dire_gold << net_worth
            log.dire_gold = dire_gold.to_json
          end
          unless xp == 0
            dire_xp = JSON.parse(log.dire_xp)
            dire_xp << xp
            log.dire_xp = dire_xp.to_json
          end
        end
        log.save

        {
          net_worth: net_worth,
          xp: xp
        }
      end

      # ---------------------------------------------------------------
      # 经济经验差
      # ---------------------------------------------------------------
      def update_team_diff(log, radiant_data, dire_data, duration)
        update_gold_diff(log, radiant_data, dire_data, duration)
        update_xp_diff(log, radiant_data, dire_data, duration)
      end

      def update_gold_diff(log, radiant_data, dire_data, duration)
        gold_diff = JSON.parse(log.gold_diff)
        gold_diff << {
          time: duration,
          data: radiant_data[:net_worth] - dire_data[:net_worth]
        }
        log.gold_diff = gold_diff.to_json
        log.save
      end

      def update_xp_diff(log, radiant_data, dire_data, duration)
        xp_diff = JSON.parse(log.xp_diff)
        xp_diff << {
          time: duration,
          data: radiant_data[:xp] - dire_data[:xp]
        }
        log.xp_diff = xp_diff.to_json
        log.save
      end


    end
  end
end