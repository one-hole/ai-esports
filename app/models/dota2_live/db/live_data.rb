# 当前live api独有的更新数据
#
module Dota2Live
  module Db
    module LiveData
      def update_live_data(data)
        @match.update(data)
      end

      def match_params(match)
        {
          radiant_team_id:            radiant_team_id(match),
          dire_team_id:               dire_team_id(match),
          left_team_gold:             radiant_gold.to_i,
          right_team_gold:            dire_gold.to_i,
          left_team_exp:              radiant_xp.to_i,
          right_team_exp:             dire_xp.to_i,
          match_id:                   match_id,
          tower_status_radiant:       radiant_tower_state,
          barracks_status_radiant:    radiant_barracks_state,
          tower_status_dire:          dire_tower_state,
          barracks_status_dire:       dire_barracks_state,
          left_team_tower_state:      radiant_tower_state,
          right_team_tower_state:     dire_tower_state,
          status:                     'ongoing',
          picks_bans:                 {left: radiant_picks(match), right: dire_picks(match)}.to_json
        }
      end

      def reversed_match_params(match)
        {
          radiant_team_id:            radiant_team_id(match),
          dire_team_id:               dire_team_id(match),
          left_team_gold:             dire_gold.to_i,
          right_team_gold:            radiant_gold.to_i,
          left_team_exp:              dire_xp.to_i,
          right_team_exp:             radiant_xp.to_i,
          match_id:                   match_id,
          tower_status_radiant:       dire_tower_state,
          barracks_status_radiant:    dire_barracks_state,
          tower_status_dire:          radiant_tower_state,
          barracks_status_dire:       radiant_barracks_state,
          left_team_tower_state:      dire_tower_state,
          right_team_tower_state:     radiant_tower_state,
          status:                     'ongoing',
          picks_bans:                 {right: radiant_picks(match), left: dire_picks(match)}.to_json
        }
      end
    end
  end
end
