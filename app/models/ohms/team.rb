module Ohms
  class Team < Ohm::Model

    attribute :battle_id
    attribute :steam_id
    attribute :name
    attribute :logo         # RealTime 里面可以拿到 Team的Logo


    unique :steam_id
    reference(:battle, "Ohms::Battle")
    collection(:players, "Ohms::Player")

    def as_info
      {
        steam_id:   self.id,
        name:       self.name,
        logo:       self.logo,
        players:    self.players_info
      }
    end

    def players_info
      infos = []
      self.players.each do |player|
        infos << player.as_info
      end
      infos
    end
  end
end