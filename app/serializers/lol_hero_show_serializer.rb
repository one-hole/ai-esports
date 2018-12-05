class LolHeroShowSerializer < LolHeroSerializer
  attributes :id, :cn_name, :en_name, :nick, :attack, :defense, :magic, :difficulty

  has_one :avatar

  def avatar
    "http://down.qq.com/qqtalk/lolApp/img/hero/#{object.offical_id}.png"
  end

  class SkillSerializer < ActiveModel::Serializer
    attributes :id, :en_name, :cn_name, :shortcut
    attributes :avatar, :back_avatar, :desc

    def shortcut
      object.short
    end

    def avatar
      "http://122.228.255.219/dlied1.qq.com/qqtalk/lolApp/img/spell/#{object.en_name}.png"
    end

    def back_avatar
      "http://122.228.255.248/dlied1.qq.com/qqtalk/lolApp/img/spell/#{object.en_name}.png"
    end
  end

  has_many :skills, each_serializer: SkillSerializer
end
