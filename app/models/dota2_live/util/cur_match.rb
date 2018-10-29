# 更新当前match
#
module Dota2Live
  module Util
    module CurMatch

      def process_cur_matches(valid_matches)
        update_live_match_ids(valid_matches)
        update_live_matches(valid_matches)
      end

      def update_live_matches(valid_matches)
        valid_matches.each do |match|
          LiveMatchLog.create_or_update(match)  # => 更新log数据，与上次数据对比获得
          LiveMatch.create_or_update(match)     # => 单纯的更新当前match数据
          update_db_match(match)                # => 更新db里的dota2_match
        end
      end

      # 创建新的live)match_id
      def update_live_match_ids(valid_games)
        puts "new match ids to create #{new_match_ids(valid_games)}"

        new_match_ids(valid_games).each do |new_match_id|
          LiveMatchId.create(match_id: new_match_id)
        end
      end

    end
  end
end