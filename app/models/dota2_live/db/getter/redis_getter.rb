# 从redis获得的数据
#
module Dota2Live
  module Db
    module Getter
      module RedisGetter
        def dire_xp
          JSON.parse(@live_match_log.dire_xp).last
        end

        def radiant_tower_state
          @live_match.radiant.tower_state
        end

        def dire_tower_state
          @live_match.dire.tower_state
        end

        def duration
          @live_match.duration.to_i
        end

        def match_id
          @live_match.match_id
        end

        def radiant_team_id(match)
          match['radiant_team']['team_id'].to_i
        end

        def dire_team_id(match)
          match['dire_team']['team_id'].to_i
        end

        def radiant_team_name(match)
          match['radiant_team']['team_name']
        end

        def dire_team_name(match)
          match['dire_team']['team_name']
        end

        def game_no(match)
          match['radiant_series_wins'].to_i + match['dire_series_wins'].to_i + 1
        end

        def radiant_barracks_state
          radiant.barracks_state
        end

        def dire_barracks_state
          dire.barracks_state
        end

        def radiant_gold
          JSON.parse(@live_match_log.radiant_gold).last.to_i
        end

        def dire_gold
          JSON.parse(@live_match_log.dire_gold).last.to_i
        end

        def radiant_lead
          radiant_gold - dire_gold
        end

        def radiant_xp
          JSON.parse(@live_match_log.radiant_xp).last
        end

        def redis_live_duration
          @live_match.duration
        end
        
        def dire_score
          dire.score.to_i
        end

        def dire
          @live_match.dire
        end
        
        def radiant_score
          radiant.score.to_i
        end
        
        def radiant
          @live_match.radiant
        end
        
        def radiant_picks(match)
          [match['scoreboard']['radiant']['picks']['pick']].flatten.map{|p| p['hero_id'].to_i}
        end
        
        def dire_picks(match)
          [match['scoreboard']['dire']['picks']['pick']].flatten.map{|p| p['hero_id'].to_i}
        end
        
      end
    end
  end
end
