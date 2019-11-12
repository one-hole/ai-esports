module Ohms
  class Player < Ohm::Model
    
    attribute :name
    attribute :account_id
    attribute :hero_id
    attribute :battle_id        # Ohm 里面保存的 BattleID
    attribute :team_id          # Ohm 里面保存的 TeamID
    attribute :level
    attribute :kill_count
    attribute :death_count
    attribute :assists_count
    attribute :denies_count
    attribute :last_hit_count
    attribute :gold
    attribute :net_worth
    attribute :abilities
    attribute :items

    attribute :x
    attribute :y

    unique :account_id
    index :battle_id

    reference(:battle, "Ohms::Battle")
    reference(:team, "Ohms::Team")


    def as_info
      {
        name:     name,
        hero:     hero_id,
        level:    level,
        kill:     kill_count,
        death:    death_count,
        assists:  assists_count,
        denies:   denies_count,
        last_hit: last_hit_count,
        gold:     gold,
        net_worth: net_worth,
        x:        x,
        y:        y,
        abilities: abilities,
        items:     items
      }
    end
  end
end