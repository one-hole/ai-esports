# encoding: utf-8

class Dota2Match < Hole::Match

  def self.async_build(battle, battle_info)

  end

  # TODO 后面需要在 Redis 里面加入标识位用来减少 IO
  def self.build(battle, battle_info)
    if (battle_info["match_id"] && battle_info["dire_series_wins"] && battle_info["radiant_series_wins"])
      battle.matches.find_or_create_by(type: 'Dota2Match', official_id: battle_info["match_id"], game_no: battle_info["dire_series_wins"] + battle_info["radiant_series_wins"] + 1)
    end
  end

  def fetch_detail

  end

end