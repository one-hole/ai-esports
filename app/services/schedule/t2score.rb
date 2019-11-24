module Schedule
  class T2score

    URL = "https://www.t2score.com/api/front/schedule/schedule_three_days"

    def initialize
      begin
        @resp = Request.get(URL, {})
        filter
      rescue => exception
        puts exception
      end
    end

    def filter
      dota2_battles = JSON.parse(@resp.body)["list"].each do |battle| 
        process(battle) if ("dota2" == battle["game_category"])
      end
    end

    # 1. 判断有没有 T2Score 之前创建的比赛
    # 2. 判断有没有其他的比赛是能匹配的（如何匹配）
    # 3. 暂时只有 T2 一家的赛程
    def process(battle_info)
      battle = Hole::Battle.find_by("trdid": "t2_#{battle_info["_id"]}")

      if battle
        process_update(battle, battle_info)
      else
        process_create(battle_info)
      end
    end

    def process_update(battle, battle_info)      
      battle.update(
        left_score:   battle_info["left_score"],
        right_score:  battle_info["right_score"],
        start_at:     battle_info["start_time"],
        status:       get_status[battle_info["state"]]
      )
    end

    def process_create(battle_info)      
      left_team  = find_or_create_team(battle_info["left_team"])
      right_team = find_or_create_team(battle_info["right_team"])
            
      Dota2Battle.create(
        manual:     false,
        left_team:  left_team,
        right_team: right_team,
        format:     battle_info["bo"],
        left_score: battle_info["left_score"],
        right_score: battle_info["right_score"],
        start_at:    battle_info["start_time"],
        status:      get_status[battle_info["state"]],
        trdid:       "t2_#{battle_info["_id"]}"
      )
    end

    # 1. 先用 ID 查找
    # 2. 然后 名字查找
    def find_or_create_team(team_info)

      team = Dota2Team.find_by(trdid: "t2_#{team_info["_id"]}")
      return team if team

      teams = Dota2Team.where(name: team_info["tag"]).or(Dota2Team.where(abbr: team_info["tag"]))
      return teams[0] unless teams.blank?
      
      team = Dota2Team.create(
        'abbr':   team_info["tag"],
        'trdid':  "t2_#{team_info["_id"]}",
        'logo':   "https://cdn.wanjujianghu.xyz#{team_info["logo"]}"
      )

      team.fetch_t2_async # 这里去异步更新

      return team
    end

    def get_status
      {
        "finish"   => 3,
        "start"    => 2,
        "upcoming" => 1
      }
    end
  end
end

# Schedule::T2score.new