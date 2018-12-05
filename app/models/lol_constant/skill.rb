module LolConstant
  class Skill < ApplicationRecord
    self.table_name = "lol_skills"

    def self.init_data
      Hero.find_each do |hero|
        sleep(0.5)
        json_body = JSON.parse(Typhoeus::Request.new(
          "http://gpcd.gtimg.cn/upload/qqtalk/lol_hero/1d/hero_#{hero.offical_id}.js"
        ).run.body)
        
        [1, 2, 3, 4, 5].each do |index|

          desc = json_body["skill#{index}_desc"]
          short = json_body["skill#{index}"]

          en_name = short.split('|')[0].split('.')[0]
          cn_name = short.split('|')[1][0..-4]
          cn_name = short.split('|')[1][0..-5] if short.include?("（被动）")
          key = short[-2] unless short.include?("（被动）")
          key = 'P' if index == 1

          obj = self.find_or_create_by(
            hero_id: hero.id,
            en_name: en_name,
            cn_name: cn_name,
            short: key
          )

          obj.update({ desc: desc })
        end
      end
    end
  end
end