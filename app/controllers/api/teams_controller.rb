module Api
  class TeamsController < BaseController

    def show
      load_team
      render json:
        @team, serializer: TeamSerializer, root: 'data'
    end

    private
      def load_team
        @team = Team.find_by(id: params[:id].to_i)
        raise TeamNotFoundError unless @team
      end
  end
end
