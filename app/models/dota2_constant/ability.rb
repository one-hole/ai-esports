module Dota2Constant
  class Ability < ApplicationRecord
    self.table_name = "dota2_abilities"

    before_create do
      self.lg_avatar = "http://rw-assets.oss-cn-hangzhou.aliyuncs.com/dota2/abilities/#{self.en_name}_lg.png"
      self.md_avatar = "http://rw-assets.oss-cn-hangzhou.aliyuncs.com/dota2/abilities/#{self.en_name}_md.png"
      self.sm_avatar = "http://rw-assets.oss-cn-hangzhou.aliyuncs.com/dota2/abilities/#{self.en_name}_sm.png"
    end

    def self.load_yml
      abilities = YAML.load_file(Rails.root.to_s + "/lib/constants/abilities.yml")
      abilities.each_pair do |key, value|
        self.find_or_create_by(steam_id: key.to_i, en_name: value.to_s)
      end
    end

    def self.init_cn
      yamls = YAML.load_file(Rails.root.to_s + "/lib/constants/abilitypedia.yml")['abilitydata']
      Ability.find_each do |ability|
        ability.cn_name = yamls[ability.en_name]['dname'] rescue nil
        ability.desc = yamls[ability.en_name]['desc'] rescue nil
        ability.save
      end
    end
  end
end
