module Api
  module V2
    class LivesController < BaseController
      def index
        load_battles
        render json: @battles
      end

      def show
      end

      private 

      def load_battles
        @battles = Hole::Battle.ongoing
      end
    end
  end
end