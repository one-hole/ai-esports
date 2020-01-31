module Api
  module V2
    class LeaguesController < BaseController

      def index
        load_leagues
        render json:
         @leagues, each_serializer: ::V2::LeaguesIndexSerializer, root: 'data', meta: meta
      end

      private

      def load_leagues
        @leagues = Hole::League.order(id: :desc).page(current_page).per(60)
      end

      def meta
        {
          current_page: current_page.to_i,
          per_page:     60,
          total_count:  Hole::League.count
        }
      end
    end
  end
end