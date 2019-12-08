# encoding: utf-8

class Dota2Match < Hole::Match

  def self.async_build(battle)
  end


  # 这里的 Battle 是 Ohms 的 Battle
  def self.build(battle)

    # 1. 如果存在 steam_id 的 match 那么直接 Pass
    return if Dota2Match.find_by(official_id: battle.steam_id)

    # 2. 需要先找到 对应的 battle
    @battle = Dota2Battle.find_by(id: battle.db_id)

    begin
      if battle.steam_id
        self.find_or_create_by(
          battle:       @battle,
          official_id:  battle.steam_id,
          game_no:      (@battle.left_score + @battle.right_score + 1)
        )
      end
    rescue => exception
      STDOUT.print exception
    end

  end

  def async_fetch_detail
    Fetch::Dota2MatchDetailWorker.perform_in(30.seconds, self.id)
  end

  # 这里如果没有抓到应该重试
  def fetch_detail

    if self.detail.detail
      return
    end

    resp = Live::MatchDetail::Request.run(self.official_id)
    body = JSON.parse(resp.body)

    unless detail
      self.ensure_detail
    end

    unless body["result"].has_key?("error") # 如果有错误就什么都不管
      detail.detail = resp.body
      detail.save
    end
  end

end


# 正在打的比赛会显示 Error
#
# 如果抓到了数据。 那么代表比赛已经结束了
