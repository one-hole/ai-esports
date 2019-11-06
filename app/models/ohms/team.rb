module Ohms
  class Team < Ohm::Model

    attribute :battle_id
    attribute :steam_id
    attribute :name

    unique :steam_id
    reference(:battle, "Ohms::Battle")
  end
end