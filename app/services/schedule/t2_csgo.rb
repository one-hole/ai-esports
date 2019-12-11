module Schedule
  module T2Csgo

    def process_csgo(battle_info)
      league = prcess_csgo_league(battle_info)
      battle = CsgoBattle.find_by("trdid": "t2_#{battle_info["_id"]}")

      if battle
        process_csgo_update(league, battle, battle_info)
      else
        process_csgo_create(league, battle_info)
      end
    end
    
    def process_csgo_update(league, battle, battle_info)
      left_team  = find_or_create_csgo_team(battle_info["left_team"])
      right_team = find_or_create_csgo_team(battle_info["right_team"])

      battle.update(
         left_team:   left_team,
        right_team:   right_team,
            league:   league,
        left_score:   battle_info["left_score"],
       right_score:   battle_info["right_score"],
          start_at:   battle_info["start_time"],
            status:   get_status[battle_info["state"]]
      ) unless battle.manual
    end

    def process_csgo_create(league, battle_info)
      left_team  = find_or_create_csgo_team(battle_info["left_team"])
      right_team = find_or_create_csgo_team(battle_info["right_team"])

      battle = CsgoBattle.create(
        manual: false,
        left_team:    left_team,
        right_team:   right_team,
        format:       battle_info["bo"],
        left_score:  battle_info["left_score"],
        right_score: battle_info["right_score"],
        start_at:    battle_info["start_time"],
        status:      get_status[battle_info["state"]],
        trdid:       "t2_#{battle_info["_id"]}",
        league:      league
      )
    end

    def find_or_create_csgo_team(team_info)
      team  = CsgoTeam.find_by(trdid: "t2_#{team_info["_id"]}")
      
      unless team
        teams = CsgoTeam.where(name: team_info["tag"]).or(CsgoTeam.where(abbr: team_info["tag"])) 
        team = teams[0] unless teams.blank?
      end

      unless team
        team = CsgoTeam.create(
          'abbr':   team_info["tag"],
          'trdid':  "t2_#{team_info["_id"]}",
          'logo':   "https://cdn.wanjujianghu.xyz#{team_info["logo"]}"
        )
        team.fetch_t2_async
      else
        team.update(
          'logo':   "https://cdn.wanjujianghu.xyz#{team_info["logo"]}"
        )
      end

      return team
    end

    def prcess_csgo_league(battle_info)
      Hole::League.find_or_create_by(game_id: 2, name: battle_info["league_name"])
    end
  end
end