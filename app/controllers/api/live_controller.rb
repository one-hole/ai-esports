module Api
  class LiveController < BaseController

    def index
      render json:
        load_series, each_serializer: LiveListSerializer, root: 'data'
    end

    private
      def unsort_series
        MatchSeries.select(needed_column).for_live_index(game_id).includes(:league, :left_team, :right_team)
      end

      def load_series
        unsort_series.order(start_time: :desc)
      end

      def needed_column
        [:id, :left_team_id, :right_team_id, :game_id, :round, :start_time, :league_id, :status, :left_score, :right_score]
      end

  end
end
