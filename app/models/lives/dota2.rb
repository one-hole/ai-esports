module Lives
  class Dota2 < ActiveType::Object

    attribute :db_match
    attribute :match
    attribute :log
    attribute :reversed

    def exec(left_team_id, right_team_id)
      load_match(left_team_id, right_team_id)
      load_log
    end

    def load_match(left_team_id, right_team_id)
      normal_match = Dota2Live::LiveMatch.find(radiant_team_id: left_team_id, dire_team_id: right_team_id).to_a.last
      reversed_match = Dota2Live::LiveMatch.find(radiant_team_id: right_team_id, dire_team_id: left_team_id).to_a.last
      unless normal_match.nil?
        self.reversed = false
        self.match = normal_match
      end
      unless reversed_match.nil?
        self.reversed = true
        self.match = reversed_match
      end
    end

    def load_log
      return if self.match.nil?
      self.log = Dota2Live::LiveMatchLog.find(match_id: self.match.match_id).first
    end

    # --------------------------------------------
    def left_radiant
      !reversed?
    end

    def status
      self.db_match.status
    end

    def left_lead
      reversed? ? -self.db_match.radiant_lead.to_i : self.db_match.radiant_lead.to_i
    end

    def radiant_lead
      self.db_match.radiant_lead.to_i
    end

    def left_team_first_blood
      self.db_match.left_team_first_blood
    end

    def left_team_ten_kills
      self.db_match.left_team_ten_kills
    end

    def reversed?
      self.reversed
    end

    def match_id
      self.match.match_id
    end

    def duration
      self.db_match.duration.to_i
    end

    def league_id
      self.match.league_id
    end

    def league
      return {
        id: -1,
        extern_id: league_id,
        name: nil,
      } unless League.exists?(extern_id: league_id)
      League.select(:extern_id, :name).find_by(extern_id: league_id)
    end

    def radiant_score
      self.match.radiant_series_wins.to_i
    end

    def dire_score
      self.match.dire_series_wins.to_i
    end

    def game_no
       radiant_score + dire_score + 1
    end

    def left_series_score
      reversed? ? dire_score : radiant_score
    end

    def right_series_score
      reversed? ? radiant_score : dire_score
    end

    def radiant
      self.match.radiant
    end

    def dire
      self.match.dire
    end

    def left_score
      self.db_match.left_team_kills
    end

    def right_score
      self.db_match.right_team_kills
    end

    def left_tower_state
      reversed? ? dire.tower_state : radiant.tower_state
    end

    def radiant_tower_state
      radiant.tower_state
    end

    def dire_tower_state
      dire.tower_state
    end

    def right_tower_state
      reversed? ? radiant.tower_state : dire.tower_state
    end

    def left_barracks_state
      reversed? ? dire.barracks_state : radiant.barracks_state
    end

    def radiant_barracks_state
      radiant.barracks_state
    end

    def dire_barracks_state
      dire.barracks_state
    end

    def right_barracks_state
      reversed? ? radiant.barracks_state : dire.barracks_state
    end

    def radiant_gold
      JSON.parse(self.log.radiant_gold)
    end

    def dire_gold
      JSON.parse(self.log.dire_gold)
    end

    def radiant_xp
      JSON.parse(self.log.radiant_xp)
    end

    def dire_xp
      JSON.parse(self.log.dire_xp)
    end

    def left_gold
      reversed? ? dire_gold.last.to_i : radiant_gold.last.to_i
    end

    def left_xp
      reversed? ? dire_xp.last.to_i : radiant_xp.last.to_i
    end

    def right_gold
      reversed? ? radiant_gold.last.to_i : dire_gold.last.to_i
    end

    def right_xp
      reversed? ? radiant_xp.last.to_i : dire_xp.last.to_i
    end

    def radiant_team_id
      self.match.radiant_team_id
    end

    def dire_team_id
      self.match.dire_team_id
    end

    def left_team
      reversed? ? team(dire_team_id) : team(radiant_team_id)
    end

    def right_team
      reversed? ? team(radiant_team_id) : team(dire_team_id)
    end

    def team(extern_id)
      return {
        id: -1,
        name: nil,
        logo: nil,
        extern_id: extern_id
      } unless Dota2Team.exists?(extern_id: extern_id)
      Dota2Team.select(:id, :name, :logo, :extern_id).find_by(extern_id: extern_id)
    end

    def radiant_picks
      JSON.parse(radiant.picks)
    end

    def dire_picks
      JSON.parse(dire.picks)
    end

    def radiant_bans
      JSON.parse(radiant.bans)
    end

    def dire_bans
      JSON.parse(dire.bans)
    end

    def left_picks
      reversed? ? dire_picks : radiant_picks
    end

    def right_picks
      reversed? ? radiant_picks : dire_picks
    end

    def left_bans
      reversed? ? dire_bans : radiant_bans
    end

    def right_bans
      reversed? ? radiant_bans : dire_bans
    end

    def left_players
      reversed? ? dire_players : radiant_players
    end

    def right_players
      reversed? ? radiant_players : dire_players
    end

    def radiant_players
      players('radiant')
    end

    def dire_players
      players('dire')
    end

    def kda(kills, death, assists)
      death = 1 if death.to_i == 0
      ((kills.to_i + assists.to_i) / death.to_f).round(1)
    end

    def account_id_to_name
      @account_id_to_name ||= JSON.parse(self.match.account_id_to_name)
    end

    def get_player_name(account_id)
      account_id_to_name[account_id]
    end

    def players(side)
      items_map = JSON.parse(self.log.items_map)
      slot = -1
      self.send(side).players.map do |player|
        slot += 1
        {
          account_id: player.account_id,
          name:       get_player_name(player.account_id),
          hero_id:    player.hero_id,
          level:      player.level,
          kda:        kda(player.kills, player.death, player.assists),
          gpm:        player.gold_per_min,
          xpm:        player.xp_per_min,
          kills:      player.kills,
          death:      player.death,
          assists:    player.assists,
          net_worth:  player.net_worth,
          last_hits:  player.last_hits,
          denies:     player.denies,
          position_x: player.position_x,
          position_y: player.position_y,
          item0:      {
            id:   player.item0,
            time: get_item_time(items_map, player.item0, player.account_id)
          },
          item1:      {
            id:   player.item1,
            time: get_item_time(items_map, player.item1, player.account_id)
          },
          item2:      {
            id:   player.item2,
            time: get_item_time(items_map, player.item2, player.account_id)
          },
          item3:      {
            id:   player.item3,
            time: get_item_time(items_map, player.item3, player.account_id)
          },
          item4:      {
            id:   player.item4,
            time: get_item_time(items_map, player.item4, player.account_id)
          },
          item5:      {
            id:   player.item5,
            time: get_item_time(items_map, player.item5, player.account_id)
          },
          abilities:  get_abilities(side, slot, player.hero_id)
        }
      end
    end

    def get_abilities(side, slot, hero_id)
      ability_ids = JSON.parse(log.send("#{side}_abilities"))[slot.to_s]

      return ability_ids.select{|ability_id| $rubick_ability_ids.include?(ability_id.to_i)} if hero_id.to_i == $rubick_hero_id
      ability_ids.reject{|ability_id| $filtered_ability_ids.include?(ability_id.to_i)}
    end

    def get_item_time(items_map, item, account_id)
      (item == '0' || items_map[account_id].nil?) ? nil : items_map[account_id][item]
    end

    def gold_diff
      JSON.parse(self.log.gold_diff)
    end

    def xp_diff
      JSON.parse(self.log.xp_diff)
    end

    def max_gold_diff
      return 0 if gold_diff.empty?
      gold_diff.max_by{|diff| diff['data']}['data']
    end

    def min_gold_diff
      return 0 if gold_diff.empty?
      gold_diff.min_by{|diff| diff['data']}['data']
    end

    def max_xp_diff
      return 0 if xp_diff.empty?
      xp_diff.max_by{|diff| diff['data']}['data']
    end

    def min_xp_diff
      return 0 if xp_diff.empty?
      xp_diff.min_by{|diff| diff['data']}['data']
    end

    def events
      JSON.parse(self.log.events)
    end

  end
end
