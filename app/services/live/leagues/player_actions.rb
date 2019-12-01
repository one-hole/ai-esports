# encoding: utf-8

module Live
  module Leagues
    module PlayerActions

      def process_player(team, player_info)        
        player = Ohms::Player.load_by(team.battle_id, player_info["account_id"])

        unless player
          player = build_player(team, player_info)
        end
      end

      # 这里我没有更新玩家的 金币 数量、因为暂时不是很好定策略
      # 大招状态的枚举值
      # 物品暂时也没有处理掉
      def process_complex_player(team, player_info)
        
        player = Ohms::Player.load_by(team.battle_id, player_info["account_id"])

        if player
          player.update(
            team_id:            team.id,
            hero_id:            [player.hero_id.to_i, player_info["hero_id"]].max,
            level:              [player.level.to_i, player_info["level"]].max,
            kill_count:         [player.kill_count.to_i, player_info["kills"]].max,
            death_count:        [player.death_count.to_i, player_info["death"]].max,
            assists_count:      [player.assists_count.to_i, player_info["assists"]].max,
            denies_count:       [player.denies_count.to_i,  player_info["denies"]].max,
            last_hit_count:     [player.last_hit_count.to_i, player_info["last_hits"]].max,
            net_worth:          [player.net_worth.to_i, player_info["net_worth"]].max,
            items:              get_items(player, player_info),
            gpm:                player_info["gold_per_min"],
            xpm:                player_info["xp_per_min"],
            slot:               player_info["player_slot"],
            ultimate_state:     player_info["ultimate_state"],
            ultimate_cooldown:  player_info["ultimate_cooldown"],
            respawn_timer:      player_info["respawn_timer"],
            x:                  player_info["position_x"],
            y:                  player_info["position_y"]
          )
        end
      end

      def get_items(player, player_info)
        return player.items if player.items
        return [player_info["item0"], player_info["item1"], player_info["item2"], player_info["item3"], player_info["item4"], player_info["item5"]]
      end

      def build_player(team, player_info)
        Ohms::Player.create(
          account_id: player_info["account_id"],
          # name:       player_info["name"],
          hero_id:    player_info["hero_id"],
          team_id:    team.id,
          battle_id:  team.battle_id
        )
      end

    end
  end
end

# hero id