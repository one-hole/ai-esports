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
        @battles = Hole::Battle.eager_load(:left_team, :right_team, :matches).ongoing
      end
    end
  end
end