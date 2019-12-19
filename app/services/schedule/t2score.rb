module Schedule
  class T2score

    include T2Csgo

    URL = "https://www.t2score.com/api/front/schedule/schedule_three_days?"

    def initialize
      begin
        @resp = Request.get(URL, {})
        @dota2_battles = JSON.parse(@resp.body)["list"].select { |item| "dota2" == item["game_category"] }
        @csgo_battles  = JSON.parse(@resp.body)["list"].select { |item| "csgo" == item["game_category"] }
        @dota2_ids = @dota2_battles.map {|battle| "t2_#{battle["_id"]}" }
      
        filter
      rescue => exception
        puts exception
      end
    end

    def filter
      @dota2_battles.each { |battle| process(battle) }
      @csgo_battles.each  { |battle| process_csgo(battle) }

      process_dota2_db_ongoing
    end

    # 1. 判断有没有 T2Score 之前创建的比赛
    # 2. 判断有没有其他的比赛是能匹配的（如何匹配）
    # 3. 暂时只有 T2 一家的赛程
    # 4. 进行中的比赛需要进行特殊处理 & 因为能抓到 Match 里面的一些盘口的细节
    def process(battle_info)
      
      begin
        league = process_league(battle_info) rescue nil
        return unless league

        battle = Hole::Battle.find_by("trdid": "t2_#{battle_info["_id"]}")
        
        if battle
          process_update(league, battle, battle_info)
        else
          process_create(league, battle_info)
        end
      rescue
        
      end
    end

    def process_update(league, battle, battle_info)
      left_team  = find_or_create_team(battle_info["left_team"])
      right_team = find_or_create_team(battle_info["right_team"])

      battle.update(
         left_team:   left_team,
        right_team:   right_team,
            league:   league,
        left_score:   battle_info["left_score"],
       right_score:   battle_info["right_score"],
          start_at:   battle_info["start_time"],
            status:   get_status[battle_info["state"]]
      ) unless battle.manual

      process_ongoing(battle, battle_info) if (2 == get_status[battle_info["state"]].to_i)
      # process_finish(battle, battle_info) if (3 == get_status[battle_info["state"]].to_i)
    end


    def process_create(league, battle_info)
      left_team  = find_or_create_team(battle_info["left_team"])
      right_team = find_or_create_team(battle_info["right_team"])

      battle = Dota2Battle.create(
        manual:      false,
        left_team:   left_team,
        right_team:  right_team,
        format:      battle_info["bo"],
        left_score:  battle_info["left_score"],
        right_score: battle_info["right_score"],
        start_at:    battle_info["start_time"],
        status:      get_status[battle_info["state"]],
        trdid:       "t2_#{battle_info["_id"]}",
        league:      league
      )

      process_ongoing(battle, battle_info) if (2 == get_status[battle_info["state"]].to_i)
      # process_finish(battle, battle_info) if (3 == get_status[battle_info["state"]].to_i)
    end

    # 这边应该只用找、找不到就放弃处理
    # 1. 获取 Match 信息
    def process_ongoing(battle, battle_info)

      match = battle.matches.where(game_no: battle.current_game_no, type: "Dota2Match").last

      if match
        do_match(match, battle_info)
      end
    end

    # 处理数据库里面进行中的 Battle
    def process_dota2_db_ongoing
      Dota2Battle.ongoing.each { |b| b.update(hidden: true) unless find_battle_in_resp(b) }
    end


    def do_match(match, battle_info)

      match.detail.update(
        left_first_blood: (battle_info["match"]["match_first_blood"] == "" ? nil : battle_info["match"]["match_first_blood"] == "left"),
        left_first_tower: (battle_info["match"]["match_first_tower"] == "" ? nil : battle_info["match"]["match_first_tower"] == "left"),
        left_ten_kills:   (battle_info["match"]["match_ten_kills"] == "" ? nil : battle_info["match"]["match_ten_kills"] == "left"),
        left_five_kills:  (battle_info["match"]["match_five_kills"] == "" ? nil : battle_info["match"]["match_five_kills"] == "left"),
        left_lead:        (battle_info["match"]["match_lead_gold"].to_i)
      )
    end

    # battle 是数据库里面查找的 进行中 的比赛
    # 这里应该返回 True 或者 False
    def find_battle_in_resp(battle)
      @dota2_ids.include?(battle.trdid)
    end

    def process_finish(battle, battle_info)
    end

    def process_league(battle_info)
      league_info = battle_info["league_id"]
      league = Hole::League.find_by("trdid": "t2_#{league_info["_id"]}")

      unless league
        league = Hole::League.create(
          name: league_info["name"],
          abbr: league_info["tag"],
          logo: "https://cdn.wanjujianghu.xyz#{league_info["icon"]}",
          trdid: "t2_#{league_info["_id"]}",
          game_id: 1
        )
      end

      return league
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
