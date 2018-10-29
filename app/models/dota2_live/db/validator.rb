# 做一些校验
#
module Dota2Live
  module Db
    module Validator
      def reverse?(match)
        @series.left_team.extern_id == dire_team_id(match) && @series.right_team.extern_id == radiant_team_id(match)
      end

      def normal?(match)
        @series.left_team.extern_id == radiant_team_id(match) && @series.right_team.extern_id == dire_team_id(match)
      end

      # 系列赛开始时间最早在12小时之前
      def start_time_wrong?
        @series.start_time < (Time.now - 12.hour).to_i
      end
    end
  end
end