class Dota2AbilitySerializer < ActiveModel::Serializer
  attributes Dota2Constant::Ability.attribute_names.delete_if { |att| att == "id" }
end
