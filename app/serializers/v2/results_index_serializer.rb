module V2
  class ResultsIndexSerializer < ActiveModel::Serializer

    attributes :id, :game_no, :battle, :detail

    def battle
      {
        id:           object.battle.id,
        status:       object.battle.status,
        left_score:   object.battle.left_score,
        right_score:  object.battle.right_score,
        left_team:    object.battle.left_team,
        right_team:   object.battle.right_team
      }
    end

    def detail
      JSON.parse(object.detail.detail) rescue {}
    end
  end
end