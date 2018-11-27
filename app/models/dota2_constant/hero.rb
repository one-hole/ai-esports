module Dota2Constant
  class Hero < ApplicationRecord
    self.table_name = "dota2_heroes"

    before_create do
      self.full_avatar = "https://rw-assets.oss-cn-hangzhou.aliyuncs.com/dota2/heroes/#{self.en_name}_full.png"
      self.lg_avatar = "https://rw-assets.oss-cn-hangzhou.aliyuncs.com/dota2/heroes/#{self.en_name}_lg.png"
      self.sm_avatar = "https://rw-assets.oss-cn-hangzhou.aliyuncs.com/dota2/heroes/#{self.en_name}_sb.png"
      self.vert_avatar = "https://rw-assets.oss-cn-hangzhou.aliyuncs.com/dota2/heroes/#{self.en_name}_vert.png"
    end

    def self.load_yaml
      heroes = YAML.load_file(Rails.root.to_s + "/lib/constants/heroes.yml")
      heroes.each_pair do |key, value|
        self.find_or_create_by(steam_id: key.to_i, en_name: value.to_s)
      end
    end

    def self.init_cn
      yamls = YAML.load_file(Rails.root.to_s + "/lib/constants/heropedia.yml")['herodata']
      Hero.find_each do |hero|
        hero.cn_name = yamls[hero.en_name]['dname'] rescue nil
        hero.dac = yamls[hero.en_name]['dac'] rescue nil
        hero.droles = yamls[hero.en_name]['droles'] rescue nil
        hero.save
      end
    end
  end
end


# Dota2Constant::Hero.delete_all
# Dota2Constant::Hero.load_yaml
