module V2
  class LivesIndexSerializer < BattlesIndexSerializer
    attributes :current_game_no
    # attributes :left_first_blood
    # attributes :left_first_tower
    # attributes :left_ten_kills

    has_many :matches

    class MatchSerializer < ActiveModel::Serializer
      attributes :id, :game_no, :left_first_blood, :left_first_tower, :left_five_kills, :left_ten_kills, :left_lead
    end

    attributes :has_live

    def  has_live
      Ohms::Battle.find(:db_id => object.id).count > 0
    end

    # has_many :matches
  end
end