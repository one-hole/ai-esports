# encoding: utf-8

require_relative "player_actions"
require_relative "match_actions"

module Live
  module Leagues
    module BattleActions

      include MatchActions
      include PlayerActions

      def process_battle(battle_info)
        if battle = find_battle(battle_info["match_id"])
          update_battle(battle, battle_info)
        else
          battle = create_battle(battle_info)
        end
      end

      def find_battle(steam_id)
        Ohms::Battle.with(:steam_id, steam_id)
      end

      def create_battle(battle_info)
        Ohms::Team.clean(battle_info["radiant_team"]["team_id"])
        Ohms::Team.clean(battle_info["dire_team"]["team_id"])

        battle = Ohms::Battle.create(
          steam_id:         battle_info["match_id"],
          dire_score:       battle_info["dire_series_wins"],
          radiant_score:    battle_info["radiant_series_wins"],
          dire_team_id:     battle_info["dire_team"]["team_id"],
          radiant_team_id:  battle_info["radiant_team"]["team_id"]
        )

        radiant_team = Ohms::Team.create(
                 id: battle_info["radiant_team"]["team_id"],
           steam_id: battle_info["radiant_team"]["team_id"],
               name: battle_info["radiant_team"]["team_name"],
               logo: battle_info["radiant_team"]["team_logo"],
          battle_id: battle.id,
        )

        dire_team = Ohms::Team.create(
                 id: battle_info["dire_team"]["team_id"],
           steam_id: battle_info["dire_team"]["team_id"],
               name: battle_info["dire_team"]["team_name"],
               logo: battle_info["dire_team"]["team_logo"],
          battle_id: battle.id,
        )

        battle_info["players"].select { |item| item["team"] == 0}.each do |player_info|
          process_player(radiant_team, player_info)
        end

        battle_info["players"].select { |item| item["team"] == 1}.each do |player_info|
          process_player(dire_team, player_info)
        end

        match = process_match(battle, battle_info)

        binding.pry
      end

      def update_battle(battle, battle_info)
        battle.update(
          radiant_score:    battle_info["radiant_series_wins"],
          dire_score:       battle_info["dire_series_wins"],
        )
      end

    end
  end
end

# BattleInfo -> Player [ 0 => Radiant 1 => Dire]

# 5114495714 EHome VS Pandas 的 MatchID
# 5114540760 更换了 MatchID
# 5114584744 第三把


# 小回合打完之后就能请求 MatchDetail 拿到最终结果
#
# 5114544428 Alliance vs Fnatic 第二回的 MatchID
# 5114607844
#
# 5114565021 Sparking vs Revive 第二回合的 MatchID
#
# VG vs Alliance
# lobby_id : 26405133883614061
# league_id 11280 (可以看到也是 成都Major)
# MatchID : 5114703150
# series_id : 386526

# TNC VS EHOME MDL 成都Major
# lobby_id : 26405133856089418 26405133906669421
# League ID : 11280 11280
# League Node ID: 494
# Match 1 ID: 5114636203 5114720467
# Series ID : 386508 386508 (这个才是唯一的)

#
# Newbee VS SAG
# lobby_id : 26405133869895812
# League ID : 11461
# Match 1 ID : 5114625521
#
# lobby_id : 26405133897124063
# MatchID : 5114689837
# League ID : 11461