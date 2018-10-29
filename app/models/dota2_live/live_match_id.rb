# 当前进行中的比赛模型
#

module Dota2Live
  class LiveMatchId < Ohm::Model
    attribute :match_id

    index :match_id

    # 当前
    def self.live_match_ids
      self.all.to_a.map{|live_match| live_match.match_id}
    end

    # 删除
    def self.delete_live_match_id(match_id)
      live_match_id = self.find(match_id: match_id).first
      live_match_id.delete unless live_match_id.nil?
      puts "deleted live match id #{match_id}"
    end
  end
end