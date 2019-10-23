module Live
  module Tops
    module Util
      module Process

        include Validator
        include BattleActions

        def process(battles)
          battles.map { |battle| process_single(battle) if valid_battle?(battle)  }
        end

        def process_single(battle)
          build_battle(battle)
        end

        def build_battle(battle)
          @battle = Battle.with(:steam_id, battle["match_id"])

          if @battle # 如果存在 
            update_battle(battle)
          else       # 如果不存在
            create_battle(battle)
          end

          # 这个地方 Update 之前需要先比对大小
          @battle = Battle.update(
            :server_steam_id => battle["server_steam_id"],
            :radiant_score   => battle["radiant_score"],
            :dire_score      => battle["dire_score"],
          ) if @battle
        end

        def build_teams(battle)
          @radiant_team = Team.with(:steam_id, battle["team_id_radiant"])

          @radiant_team = Team.create(
            steam_id:  battle["team_id_radiant"],
            name:      battle["team_name_radiant"],
          ) unless @radiant_team

          @dire_team = Team.with(:steam_id, battle["team_id_dire"])
        end


      end
    end
  end
end
