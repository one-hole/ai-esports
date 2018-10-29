# 更新结束match
#
module Dota2Live
  module Util
    module FinishedMatch

      def process_finished_matches(valid_games)
        puts "[FINISHED] matches to process #{finished_match_ids(valid_games)}"

        finished_match_ids(valid_games).each do |match_id|
          process_finished_match(match_id)
          remove_live_match_id(match_id)    # => 移除进行中比赛的id记录
        end
      end

      def process_finished_match(match_id)
        match = Dota2Match.find_by(match_id: match_id)
        if match.nil?
          process_unmapped_finished_match(match_id)
        else
          process_mapped_finished_match(match, match_id)
        end
      end

      # 处理没有db对应的结束的match
      def process_unmapped_finished_match(match_id)
        live_match = live_match(match_id)
        live_match_log = live_match_log(match_id)
        clean_redis(live_match, live_match_log)
      end

      # 处理有db对应的结束的match
      def process_mapped_finished_match(match, match_id)
        store_db_and_clean_redis(match, match_id)
        match.async_update_match
      end

      # 这里入库Steam Web API不能提供的东西,然后删除LiveMatch和LiveMatchLog
      def store_db_and_clean_redis(match, match_id)
        live_match = live_match(match_id)
        live_match_log = live_match_log(match_id)
        if !live_match.nil? && !live_match_log.nil?
          store_live_data(match, live_match, live_match_log)
          clean_redis(live_match, live_match_log)
        end
      end

      def live_match(match_id)
        LiveMatch.find(match_id: match_id).first
      end

      def live_match_log(match_id)
        LiveMatchLog.find(match_id: match_id).first
      end

      def clean_redis(live_match, live_match_log)
        unless live_match.nil?
          clean_team_data(live_match.radiant)
          clean_team_data(live_match.dire)
          clean_live_match(live_match)
        end
        clean_live_match_log(live_match_log)
      end

      def clean_live_match_log(live_match_log)
        live_match_log.delete unless live_match_log.nil?
      end

      def clean_live_match(live_match)
        live_match.delete unless live_match.nil?
      end

      def clean_team_data(team)
        team.players.each do |player|
          player.delete
        end
        team.delete
      end

      def store_live_data(match, live_match, live_match_log)
        match.store_live_data(
          {
            gold_diff:  live_match_log.gold_diff,
            xp_diff:    live_match_log.xp_diff
          }.to_json,
          live_match_log.items_map,
          live_match.account_id_to_name,
          live_match_log.events
        )
      end

    end
  end
end