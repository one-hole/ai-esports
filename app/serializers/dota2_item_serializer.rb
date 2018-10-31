class Dota2ItemSerializer < ActiveModel::Serializer
  attributes Dota2Constant::Item.attribute_names.delete_if { |att| att == "id" }
end
