# encoding: utf-8

class Dota2Match < Hole::Match

  def self.async_build(battle)

  end

  def self.build(battle)

    if battle.steam_id
      self.find_or_create_by(
       type:    'Dota2Match',
  battle_id:    battle.db_id.to_i,
official_id:    battle.steam_id.to_i,
    game_no:    (battle.radiant_score.to_i + battle.dire_score.to_i + 1)
      )
    end
  end

  def async_fetch_detail
    Fetch::Dota2MatchDetailWorker.perform_in(2.minutes, self.id)
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
