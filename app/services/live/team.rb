module Live
  class Team < Ohm::Model
    attribute :name
    attribute :logo
    attribute :steam_id
    attribute :battle_id

    index :name

    collection(:players, 'Live::Player')
    reference(:battle, 'Live::Battle')
  end
end