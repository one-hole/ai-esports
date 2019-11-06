module Ohms
  class Team < Ohm::Model

    attribute :battle_id
    attribute :steam_id
    attribute :name

    unique :steam_id
    reference(:battle, "Ohms::Battle")

    def as_info
      {
        name: self.name
      }
    end
  end
end