module V2
  class LivesIndexSerializer < BattlesIndexSerializer
    attributes :current_game_no

    attributes :has_live

    def  has_live
      Ohms::Battle.find(:db_id => object.id).count > 0
    end

    # has_many :matches
  end
end