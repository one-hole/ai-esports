# encoding: utf-8

class Dota2Match < Hole::Match

  has_one    :detail, foreign_key: "match_id", class_name: "MatchDetail"
  delegate   :left_first_blood, :left_first_tower, :left_five_kills, :left_ten_kills, :left_lead, to: :detail

  def self.async_build(battle)
  end

  after_create_commit do
    ensure_detail
  end

  def ensure_detail
    self.create_detail
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

  # 将 OHM 里面的数据同步到数据库里面
  def sync_detail
    ohm_battle = Ohms::Battle.with(:steam_id, self.official_id)
    self.ensure_detail unless detail

    detail.update(
      live_detail: ohm_battle.as_info.to_json
    )
    
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

    self.ensure_detail unless detail

    unless body["result"].has_key?("error") # 如果有错误就什么都不管
      detail.detail = resp.body
      detail.save
    end
  end

end


# 正在打的比赛会显示 Error
#
# 如果抓到了数据。 那么代表比赛已经结束了
