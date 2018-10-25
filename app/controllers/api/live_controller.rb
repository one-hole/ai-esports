module Api
  class LiveController < BaseController

    def index
      render json:
        unsort_series, each_serializer: ScheduleSerializer, root: 'data'
    end

    private
      def unsort_series
        MatchSeries.select(needed_column).for_live_index(game_id).includes(:league, :left_team, :right_team)
      end

      def needed_column
        [:id, :left_team_id, :right_team_id, :game_id, :round, :start_time, :league_id, :status]
      end

      def game_id
        params.fetch(:game_id, 1)
      end

  end
end
