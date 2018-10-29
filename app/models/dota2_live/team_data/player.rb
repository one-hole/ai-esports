# 选手数据
#
module Dota2Live
  class TeamData
    class Player < Ohm::Model
      attribute :player_slot
      attribute :account_id
      attribute :hero_id
      attribute :kills
      attribute :death
      attribute :assists
      attribute :last_hits
      attribute :denies
      attribute :gold
      attribute :level
      attribute :gold_per_min
      attribute :xp_per_min
      attribute :ultimate_state
      attribute :ultimate_cooldown
      attribute :item0
      attribute :item1
      attribute :item2
      attribute :item3
      attribute :item4
      attribute :item5
      attribute :respawn_timer
      attribute :position_x
      attribute :position_y
      attribute :net_worth
      attribute :abilities

      index :account_id

      def self.build(player)
        account_id = player['account_id']
        self.create(
          player_slot:        player['player_slot'],
          account_id:         account_id,
          hero_id:            player['hero_id'],
          kills:              player['kills'],
          death:              player['death'],
          assists:            player['assists'],
          last_hits:          player['last_hits'],
          denies:             player['denies'],
          gold:               player['gold'],
          level:              player['level'],
          gold_per_min:       player['gold_per_min'],
          xp_per_min:         player['xp_per_min'],
          ultimate_state:     player['ultimate_state'],
          ultimate_cooldown:  player['ultimate_cooldown'],
          item0:              player['item0'],
          item1:              player['item1'],
          item2:              player['item2'],
          item3:              player['item3'],
          item4:              player['item4'],
          item5:              player['item5'],
          respawn_timer:      player['respawn_timer'],
          position_x:         player['position_x'],
          position_y:         player['position_y'],
          net_worth:          player['net_worth'],
        )
      end

      def update_player(player)
        self.update(
          kills:              player['kills'],
          death:              player['death'],
          assists:            player['assists'],
          hero_id:            player['hero_id'],
          last_hits:          player['last_hits'],
          denies:             player['denies'],
          gold:               player['gold'],
          level:              player['level'],
          gold_per_min:       player['gold_per_min'],
          xp_per_min:         player['xp_per_min'],
          ultimate_state:     player['ultimate_state'],
          ultimate_cooldown:  player['ultimate_cooldown'],
          item0:              player['item0'],
          item1:              player['item1'],
          item2:              player['item2'],
          item3:              player['item3'],
          item4:              player['item4'],
          item5:              player['item5'],
          respawn_timer:      player['respawn_timer'],
          position_x:         player['position_x'],
          position_y:         player['position_y'],
          net_worth:          player['net_worth'],
        )
      end
    end
  end
end