# 各种match_id的获取
#
module Dota2Live
  module Util
    module MatchID

      # 通过请求Steam API 获得的当前match id
      def cur_match_ids(valid_games)
        cur_match_ids = valid_games.map{|game| game['match_id'].to_s}
        cur_match_ids
      end

      # 已结束的match id
      def finished_match_ids(valid_games)
        cur_match_ids = cur_match_ids(valid_games)
        live_match_ids - cur_match_ids
      end

      # Redis里存储的进行中的match id
      def live_match_ids
        LiveMatchId.live_match_ids
      end

      # 新开始的match id
      def new_match_ids(valid_games)
        cur_match_ids(valid_games) - live_match_ids
      end

      def remove_live_match_id(match_id)
        LiveMatchId.delete_live_match_id(match_id)
      end
    end
  end
end