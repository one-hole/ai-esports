class LolHeroSerializer < ActiveModel::Serializer
  attributes :id, :cn_name, :en_name, :nick, :attack, :defense, :magic, :difficulty

  has_one :avatar

  def avatar
    "http://down.qq.com/qqtalk/lolApp/img/hero/#{object.offical_id}.png"
  end
end