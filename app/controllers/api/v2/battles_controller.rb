module Api
  module V2
    class BattlesController < BaseController

      # 赛程列表
      def index
        load_battles
        render json: 
          @battles, each_serializer: ::V2::BattlesIndexSerializer, root: 'data', meta: meta
      end

      # 查看赛程
      def show
      end

      private

      def load_battles
        @battles = Hole::Battle.includes(:left_team, :right_team).order(start_at: :desc).page(current_page).per(60)
      end

      def meta
        {
          current_page: current_page.to_i,
          per_page:     60,
          total_count:  Hole::Battle.count
        }
      end
    end
  end
end

# 1. 可以按照日前查询
# 2. 可以按照时间区间查询
# 3. 可以按照游戏类型查询
# 4. 可以按照队伍的 ID 查询
# 5. 可以更具状态查询