class Dota2HeroSerializer < ActiveModel::Serializer
  attributes Dota2Constant::Hero.attribute_names.delete_if { |att| att == "id" }
end
