module Ohms
  class Player < Ohm::Model
    
    attribute :name
    attribute :account_id
    attribute :hero_id
    attribute :battle_id        # Ohm 里面保存的 BattleID
    attribute :team_id          # Ohm 里面保存的 TeamID

    unique :account_id
    index :battle_id
  end
end