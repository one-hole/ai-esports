# 选手相关信息
#
module Dota2Live
  module MatchLog
    module Player

      def get_prev_player(prev_match, team_side, account_id)
        prev_match.send(team_side).players.find(account_id: account_id).first
      end

      def radiant_players(match)
        match['scoreboard']['radiant']['players']['player']
      end

      def dire_players(match)
        match['scoreboard']['dire']['players']['player']
      end

      def update_players_event(log, match, prev_match, players, team_side, duration)
        players = [] if players.nil?
        players.each do |player|
          update_player_event(log, match, prev_match, player, team_side, duration)
        end
      end

      def update_player_event(log, match, prev_match, player, team_side, duration)
        account_id = player['account_id']
        prev_player = get_prev_player(prev_match, team_side, account_id)
        return if prev_player.nil?
        update_kills_event(log, account_id, player, prev_player, duration)
        update_deaths_event(log, account_id, player, prev_player, duration)
        update_items_event(log, account_id, player, prev_player, duration)
      end

      # ---------------------------------------------------------------------
      # 击杀事件
      # ---------------------------------------------------------------------
      def update_kills_event(log, account_id, player, prev_player, duration)
        kill_count = player['kills'].to_i - prev_player.kills.to_i
        if kill_count > 0
          events = JSON.parse(log.events)
          events << {
            time: duration,
            type: 'kill',
            account_id: account_id,
            kill_count: kill_count
          }
          log.events = events.to_json
          log.save
        end
      end

      # ---------------------------------------------------------------------
      # 死亡事件
      # ---------------------------------------------------------------------
      def update_deaths_event(log, account_id, player, prev_player, duration)
        death_count = player['death'].to_i - prev_player.death.to_i
        if death_count > 0
          events = JSON.parse(log.events)
          events << {
            time: duration,
            type: 'death',
            account_id: account_id,
            death_count: death_count
          }
          log.events = events.to_json
          log.save
        end
      end

      # --------------------------------------------------------------------
      # 物品事件
      # --------------------------------------------------------------------
      def update_items_event(log, account_id, player, prev_player, duration)
        old_items = get_item_set(prev_player, true)
        new_items = get_item_set(player, false)
        bought_items = new_items - old_items
        update_bought_items(log, bought_items, account_id, duration)
      end

      def get_item_set(player, is_prev)
        item_set = Set.new
        (1..5).each do |n|
          item_id = "item#{n}"
          item = is_prev ? player.send(item_id) : player[item_id]
          next if item == '0' || item == 0
          item_set.add(item.to_i)
        end
        item_set
      end

      def update_bought_items_worker(log, bought_items, account_id, duration)
        events = JSON.parse(log.events)
        events << {
          time: duration,
          account_id: account_id,
          type: 'bought',
          bought_items: bought_items.to_a
        }
        log.events = events.to_json
        log.save
      end

      def update_items_map(log, bought_items, account_id, duration)
        items_map = JSON.parse(log.items_map)
        items_map[account_id] = {} unless items_map.key?(account_id)
        bought_items.each do |item|
          items_map[account_id][item] = duration
        end
        log.items_map = items_map.to_json
        log.save
      end

      def update_bought_items(log, bought_items, account_id, duration)
        if bought_items.count > 0
          update_bought_items_worker(log, bought_items, account_id, duration)
          update_items_map(log, bought_items, account_id, duration)
        end
      end

    end
  end
end
