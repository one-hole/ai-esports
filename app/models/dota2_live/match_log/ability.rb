# 技能相关的一些更新
# TODO: 目前不准确
#
module Dota2Live
  module MatchLog
    module Ability

      def update_abilities(log, match, prev_match)
        radiant_abilities =  match['scoreboard']['radiant']['abilities']
        dire_abilities =  match['scoreboard']['dire']['abilities']
        prev_radiant_abilities = JSON.parse(prev_match.radiant.abilities)
        prev_dire_abilities = JSON.parse(prev_match.dire.abilities)
        update_abilities_worker(log, radiant_abilities, prev_radiant_abilities,'radiant')
        update_abilities_worker(log, dire_abilities, prev_dire_abilities, 'dire')
      end

      def update_abilities_worker(log, abilities, prev_abilities, side)
        return if abilities.nil? || prev_abilities.nil?
        return if abilities.count != 5 || prev_abilities.count != 5
        0.upto(4) do |slot|
          old_ability = [prev_abilities[slot]['ability']].flatten
          ability = [abilities[slot]['ability']].flatten
          new_ability_ids = (ability - old_ability).map{|ab| ab['ability_id']}.reject{|ability_id| $filtered_ability_ids.include?(ability_id.to_i)}
          temp_abilities = JSON.parse(log.send("#{side}_abilities"))
          temp_abilities[slot.to_s] += new_ability_ids
          if side == 'radiant'
            log.radiant_abilities = temp_abilities.to_json
          else
            log.dire_abilities = temp_abilities.to_json
          end
          log.save
        end
      end

    end
  end
end