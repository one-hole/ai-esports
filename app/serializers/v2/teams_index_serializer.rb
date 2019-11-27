module V2
  class TeamsIndexSerializer < ActiveModel::Serializer
    attributes :id, :type, :name, :abbr, :country, :logo
  end
end