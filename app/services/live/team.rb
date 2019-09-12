module Live
  class Team < Ohm::Model
    attribute :name

    index :name

    collection :players, "Live::Player"
  end
end