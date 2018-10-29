# 队伍信息
#
module Dota2Live
  class TeamData < Ohm::Model
    attribute :score
    attribute :tower_state
    attribute :barracks_state
    attribute :picks
    attribute :bans
    attribute :abilities

    set :players, :Player

    def self.build(team, side, match_id)
      abilities = team['abilities']
      team_data = self.create(
        score:          team['score'],
        tower_state:    team['tower_state'],
        barracks_state: team['barracks_state'],
        picks:          [team['picks']['pick']].flatten.map{|pick| pick['hero_id']}, # 愚蠢的steam可能返回hash或者array
        bans:           [team['bans']['ban']].flatten.map{|ban| ban['hero_id']},
        abilities:      abilities.nil? ? [] : abilities.to_json
        )

      [team['players']['player']].flatten.each do |player|
        team_data.players.add(Player.build(player))
      end

      update_ability(abilities, side, match_id)

      team_data
    end

    def self.update_ability(abilities, side, match_id)
      return if abilities.nil? || abilities.count != 5
      log = LiveMatchLog.find(match_id: match_id).first
      return if log.nil?
      0.upto(4) do |slot|
        ability = [abilities[slot]['ability']].flatten
        new_ability_ids = ability.map{|ab| ab['ability_id']}.reject{|ability_id| $filtered_ability_ids.include?(ability_id.to_i)}
        temp_abilities = JSON.parse(log.send("#{side}_abilities"))
        temp_abilities[slot.to_s] += new_ability_ids
        if side == 'radiant'
          log.radiant_abilities = temp_abilities.to_json
        else
          log.dire_abilities = temp_abilities.to_json
        end
        log.save
      end
    end

    def update_data(team)
      abilities = team['abilities']
      self.update(
        score:          team['score'],
        tower_state:    team['tower_state'],
        barracks_state: team['barracks_state'],
        picks:          [team['picks']['pick']].flatten.map{|pick| pick['hero_id']},
        bans:           [team['bans']['ban']].flatten.map{|ban| ban['hero_id']},
        abilities:      abilities.nil? ? [] : abilities.to_json
      )

      [team['players']['player']].flatten.each do |player|
        self_player = self.players.find(account_id: player['account_id']).first
        next if self_player.nil?
        self_player.update_player(player)
      end
    end

  end
end