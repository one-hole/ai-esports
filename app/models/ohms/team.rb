module Ohms
  class Team < Ohm::Model

    attribute :db_id        # 队伍对应的数据库 ID
    attribute :battle_id    # Ohms::Battle 的 ID
    attribute :steam_id
    attribute :name
    attribute :logo         # RealTime 里面可以拿到 Team的Logo


    index :steam_id
    index :battle_id

    reference(:battle, "Ohms::Battle")
    collection(:players, "Ohms::Player")

    def info
      [self.steam_id.to_i, self.name.downcase.strip]
    end

    def as_info
      {
        steam_id:   self.steam_id,
        db_id:      self.db_id,
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

    def destory
      self.delete
    end

    def self.load_by(steam_id, battle_id)
      Ohms::Team.find(:steam_id => steam_id, :battle_id => battle_id).first
    end

    def self.clean(steam_id, battle_id)
      team = load_by(steam_id, battle_id)
      team.destory if team
    end
  end
end