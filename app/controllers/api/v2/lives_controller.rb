module Api
  module V2
    class LivesController < BaseController
      def index
        load_battles
        render json:
          @battles, each_serializer: ::V2::LivesIndexSerializer, root: 'data'
      end

      private

      def load_battles
        @battles = Hole::Battle.filters(filter_params).eager_load(:left_team, :right_team, :matches).ongoing
      end

      def filter_params
        params.permit!.slice(:game)
      end
    end
  end
end