module Live
  class Player < Ohm::Model

    attribute :account_id
    attribute :hero_id
    attribute :player_slot
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
    attribute :team_id

    index :team_id

    reference(:team, 'Live::Team')
  end
end