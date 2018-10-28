module Api
  class TeamvsController < BaseController

    before_action :check

    def index

    end

    private
      def load_first_team
      end

      def load_second_team
      end

      def check
        check_team_params
        check_team_unsame
      end

      def check_team_params
        raise TeamvsParamsError unless (params.fetch(:left_team_id, false) && params.fetch(:right_team_id, false))
      end

      def check_team_unsame
        raise SameTeamError if (params.fetch(:left_team_id, false) == params.fetch(:right_team_id, false))
      end
  end
end
