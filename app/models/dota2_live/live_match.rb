# 单场比赛的数据
#
module Dota2Live
  class LiveMatch < Ohm::Model

    attribute :match_id
    attribute :radiant_team_id
    attribute :dire_team_id
    attribute :league_id
    attribute :radiant_series_wins
    attribute :dire_series_wins
    attribute :duration
    attribute :roshan_respawn_timer
    attribute :account_id_to_name

    reference :radiant, TeamData
    reference :dire, TeamData

    index :match_id
    index :radiant_team_id
    index :dire_team_id

    def self.delete_live_match(match_id)
      live_match = self.find(match_id: match_id).first
      live_match.delete unless live_match.nil?
      puts "delete live match #{match_id}"
    end

    def self.create_or_update(match)
      live_match = self.find(match_id: match['match_id']).first
      create_match(match) if live_match.nil?
      update_match(match, live_match) unless live_match.nil?
    end

    def self.create_match(match)
      self.create(
        match_id:             match['match_id'],
        radiant_team_id:      match['radiant_team']['team_id'],
        dire_team_id:         match['dire_team']['team_id'],
        league_id:            match['league_id'],
        radiant_series_wins:  match['radiant_series_wins'],
        dire_series_wins:     match['dire_series_wins'],
        duration:             match['scoreboard']['duration'],
        roshan_respawn_timer: match['scoreboard']['roshan_respawn_timer'],
        account_id_to_name:   get_account_id_to_name(match['players']['player']),
        radiant:              TeamData.build(match['scoreboard']['radiant'], 'radiant', match['match_id']),
        dire:                 TeamData.build(match['scoreboard']['dire'], 'dire', match['match_id']),
      )
    end

    def self.get_account_id_to_name(players)
      account_id_to_name = {}
      players.each do |player|
        account_id_to_name[player['account_id']] = player['name']
      end
      account_id_to_name.to_json
    end

    def self.update_match(match, live_match)
      live_match.update(
        duration:             match['scoreboard']['duration'],
        roshan_respawn_timer: match['scoreboard']['roshan_respawn_timer']
      )
      live_match.radiant.update_data(match['scoreboard']['radiant'])
      live_match.dire.update_data(match['scoreboard']['dire'])
    end

  end
end
