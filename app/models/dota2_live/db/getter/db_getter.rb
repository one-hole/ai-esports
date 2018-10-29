# 从db query的数据

module Dota2Live
  module Db
    module Getter
      module DbGetter
        def radiant_team(match)
          Dota2Team.find_by(extern_id: radiant_team_id(match))
        end

        def dire_team(match)
          Dota2Team.find_by(extern_id: dire_team_id(match))
        end

        def db_live_duration
          @match.duration
        end

        def db_left_team_kills
          @match.left_team_kills
        end

        def db_right_team_kills
          @match.right_team_kills
        end

        def db_radiant_lead
          @match.radiant_lead
        end

        def db_left_team_first_blood
          @match.left_team_first_blood
        end

        def db_left_team_ten_kills
          @match.left_team_ten_kills
        end

        def db_duration
          @match.duration
        end

      end
    end
  end
end
