# encoding: utf-8

require_relative 'player_actions'

module Live
  module Leagues
    module MatchActions

      include PlayerActions

      def process_match(battle, battle_info)
        match = load_match(battle.id)

        if match
          match = update_match(match, battle_info)
        else
          match = build_match(battle, battle_info)
        end
      end

      def update_match(match, battle_info)
        # 这里需要确定哪些是 LiveLeague 特有的
        scoreboard_info = battle_info["scoreboard"]

        match.update(
             updated_at:    Time.now,
             dire_score:    [scoreboard_info["dire"]["score"],    dire_score].max,
             radiant_score: [scoreboard_info["radiant"]["score"], radiant_score].max,
       dire_tower_state:    scoreboard_info["dire"]["tower_state"],
    radiant_tower_state:    scoreboard_info["radiant"]["tower_state"],
    dire_barracks_state:    scoreboard_info["dire"]["barracks_state"],
 radiant_barracks_state:    scoreboard_info["radiant"]["barracks_state"],
   roshan_respawn_timer:    scoreboard_info["roshan_respawn_timer"]
        )
      end

      def build_match(battle, battle_info)

        scoreboard_info = battle_info["scoreboard"]

        match = Ohms::Match.create(
           steam_id:     battle_info["match_id"],
          battle_id:     battle.id,
           duration:     scoreboard_info["duration"],
roshan_respawn_timer:    scoreboard_info["roshan_respawn_timer"],
          dire_score:    scoreboard_info["dire"]["score"],
       radiant_score:    scoreboard_info["radiant"]["score"],
    dire_tower_state:    scoreboard_info["dire"]["tower_state"],
 radiant_tower_state:    scoreboard_info["radiant"]["tower_state"],
 dire_barracks_state:    scoreboard_info["dire"]["barracks_state"],
radiant_barracks_state:  scoreboard_info["radiant"]["barracks_state"],
          dire_picks:    (scoreboard_info["dire"]["picks"].map { |item| item["hero_id"] } rescue []),
       radiant_picks:    (scoreboard_info["radiant"]["picks"].map { |item| item["hero_id"] } rescue []),
           dire_bans:    (scoreboard_info["dire"]["bans"].map { |item| item["hero_id"] } rescue []),
        radiant_bans:    (scoreboard_info["radiant"]["bans"].map { |item| item["hero_id"] } rescue []),
          created_at:    Time.now,
          updated_at:    Time.now
        )

        battle.match_id = match.id
        battle.save
        return match
      end

      def load_match(battle_id)
        Ohms::Match.with(:battle_id, battle_id)
      end

    end
  end
end

# 应该还需要补全 Player 的数据