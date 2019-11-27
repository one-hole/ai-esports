module Api
  module V2
    class TeamsController < BaseController

      def index
        load_teams
        render json:
          @teams, each_serializer: ::V2::TeamsIndexSerializer, root: 'data', meta: meta
      end

      def show
        team = Hole::Team.find_by(id: params[:id])
        render json:
          team, serializer: ::V2::TeamsIndexSerializer, root: 'data'
      end

      private

      def load_teams
        @teams = Hole::Team.page(current_page).per(60)
      end

      def meta
        {
          per_page:     60,
          current_page: current_page,
          total_count:  Hole::Team.count
        }
      end
    end
  end
end