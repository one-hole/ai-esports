module Api
  class LiveController < BaseController

    def index
      render json:
        load_series, each_serializer: LiveListSerializer, root: 'data', meta: meta
    end

    # Live详情 & 传入参数是当前的需要查看的 SeriesID
    def show
      # render json:
      #   load_single_series, serializer: LiveSerializer, root: 'data'
      load_single_series
      load_match
    end

    private
      def unsort_series
        MatchSeries.select(needed_column).for_live_index(game_id).includes(:league, :left_team, :right_team)
      end

      def load_series
        unsort_series.order(start_time: :desc)
      end

      # Live 的参数就是这样的
      def load_single_series
        @series = MatchSeries.find_by(id: params[:id])
        raise SeriesNotFoundError unless @series
        raise SeriesNotLivingError unless @series.ongoing?
      end

      def load_match
        @match ||= @series.current_match
        raise CurrentMatchNotFoundError unless @match
      end

      def load_live

      end

      def needed_column
        [:id, :left_team_id, :right_team_id, :game_id, :round, :start_time, :league_id, :status, :left_score, :right_score]
      end

      def meta
        basic_meta
      end

  end
end
