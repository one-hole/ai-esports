module V2
  class LivesIndexSerializer < BattlesIndexSerializer
    attributes :current_game_no

    belongs_to :league
    has_one :matches

    class Dota2MatchSerializer < ActiveModel::Serializer
      attributes :id, :game_no, :left_first_blood, :left_first_tower, :left_five_kills, :left_ten_kills, :left_lead
    end

    class CsgoMatchSerializer < ActiveModel::Serializer
      attributes :id, :game_no, :first_half_left_t, :left_win_five, :left_win_1, :left_win_16, :first_half_left_score, :first_half_right_score, :second_half_left_score, :second_half_right_score, :map
    end

    attribute :has_live, if: -> { object.class == Dota2Battle }

    def has_live
      Ohms::Battle.find(:db_id => object.id).count > 0
    end

    def matches

      if object.class == Dota2Battle
        return Dota2Match.where(id: Dota2Match.find_by_sql([" (SELECT SUBSTRING_INDEX(GROUP_CONCAT(id), ',' ,-1) AS id FROM hole_matches WHERE `battle_id`= ? GROUP BY `battle_id`, `game_no`)", object.id]).pluck(:id)).eager_load(:detail)
      end

      if object.class == CsgoBattle
        return object.matches.where(game_no: 1..(object.left_score + object.right_score + 1))
      end

    end
  end
end