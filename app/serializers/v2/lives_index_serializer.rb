module V2
  class LivesIndexSerializer < BattlesIndexSerializer
    attributes :current_game_no

    has_many :matches

    class MatchSerializer < ActiveModel::Serializer
      attributes :id, :game_no, :left_first_blood, :left_first_tower, :left_five_kills, :left_ten_kills, :left_lead
    end

    attributes :has_live

    def  has_live
      Ohms::Battle.find(:db_id => object.id).count > 0
    end

    def matches
      Dota2Match.where(id: Dota2Match.find_by_sql([" (SELECT SUBSTRING_INDEX(GROUP_CONCAT(id), ',' ,-1) AS id FROM hole_matches WHERE `battle_id`= ? GROUP BY `battle_id`, `game_no`)", object.id]).pluck(:id)).eager_load(:detail)
    end
  end
end