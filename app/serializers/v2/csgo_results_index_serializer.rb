module V2
  class CsgoResultsIndexSerializer < ActiveModel::Serializer
    attributes :id, :game_no, :battle, :detail

    class TeamSerializer < ActiveModel::Serializer
      attributes :id, :name, :country, :logo
    end

    def battle
      {
        id: object.battle.id,
        status:       object.battle.status,
        format:       object.battle.format,
        left_score:   object.battle.left_score,
        right_score:  object.battle.right_score,
        left_team:    ActiveModelSerializers::SerializableResource.new(object.battle.left_team, {serializer: TeamSerializer}),
        right_team:   ActiveModelSerializers::SerializableResource.new(object.battle.right_team, {serializer: TeamSerializer})
      }
    end
  end
end