module Api
  class LiveController < BaseController

    def index
      render json:
        load_series, each_serializer: LiveListSerializer, root: 'data'
    end

    # Live详情 & 传入参数是当前的需要查看的 SeriesID
    def show
      render json:
        load_single_series, serializer: LiveSerializer, root: 'data'
    end

    private
      def unsort_series
        MatchSeries.select(needed_column).for_live_index(game_id).includes(:league, :left_team, :right_team)
      end

      def load_series
        unsort_series.order(start_time: :desc)
      end

      def load_single_series
        @series = MatchSeries.find_by(id: params[:id])
      end

      def needed_column
        [:id, :left_team_id, :right_team_id, :game_id, :round, :start_time, :league_id, :status, :left_score, :right_score]
      end

  end
end
