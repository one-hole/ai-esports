module Schedule
  class T2score

    URL = "https://www.t2score.com/api/front/schedule/schedule_three_days"

    def initialize
      @resp = Request.get(URL, {})
      
      binding.pry
      
      filter
    end

    def filter
      dota2_battles = JSON.parse(@resp.body)["list"].each do |battle| 
        process(battle) if ("dota2" == battle["game_category"])
      end
    end

    # 1. 判断有没有 T2Score 之前创建的比赛
    # 2. 判断有没有其他的比赛是能匹配的（如何匹配）
    def process(battle_info)
      battle = Hole::Battle.find_by("3rdid": battle_info["_id"])
      if battle
        
      else
      end
    end

    def process_update(battle, battle_info)
    end

    def do_map
      
    end

  end
end