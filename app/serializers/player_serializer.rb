class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :personaname, :officalname, :account_id, :avatar
end