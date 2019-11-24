module Api
  module V2
    class BattlesController < BaseController

      # 赛程列表
      def index
        load_battles
        render json: @battles
      end

      # 查看赛程
      def show
      end

      private

      def load_battles
        @battles = Hole::Battle.all
      end
    end
  end
end