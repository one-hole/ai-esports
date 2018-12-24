module Api
  class TeamsController < BaseController

    def show
      load_team
      render json:
        @team, serializer: TeamSerializer, root: 'data'
    end

    def index
      load_teams
      render json:
        @teams, each_serializer: TeamSerializer, root: 'data', meta: meta
    end

    private
      def load_team
        @team = Team.find_by(id: params[:id].to_i)
        raise TeamNotFoundError unless @team
      end

      def load_teams
        @teams ||= Team.filters(filters_params).page(current_page).per(per_page)
      end

      def filters_params
        params.permit!.slice(:game_id)
      end

      def meta
        {
          current_page: current_page,
          per_page: per_page,
          total_count: Team.filters(filters_params).count
        }.merge(
          basic_meta
        )
      end
  end
end
