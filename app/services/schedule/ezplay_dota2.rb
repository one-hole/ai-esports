module Schedule
  module EzplayDota2

    def process_upcoming_dota2(battle)
      battle = find_dota2_battle_by_trdid("ez_#{battle["id"]}")

      if battle

      else
        create_dota2_battle(battle)
      end
    end

    def process_start_dota2(battle)
      puts "++++++++++++++"
    end


    def find_dota2_team(team)
      # team = Dota2Team.find_by()
    end

    # 比赛开始时间上下 90 分钟
    def find_dota2_battle(battle)
    end

    def find_dota2_battle_by_trdid(trdid)
      Hole::Battle.find_by(trdid: trdid)
    end

    def create_dota2_battle(battle)

    end
  end
end

# 从哪个平台爬的 哪个平台接管后续
# 所以这边如果抓到了 Live 那么只需要找到对应的 trdid 的 Battle 进行后续更新即可
#
# 5e801dc39173c219fdc99ea6
# 5e801dc39173c219fdc99ea6