class Dota2HeroSerializer < ActiveModel::Serializer
  attributes Dota2Constant::Hero.attribute_names.delete_if { |att| att == "id" }

  def vert_avatar
     object.vert_avatar.gsub(".png", ".jpg")
  end
end
