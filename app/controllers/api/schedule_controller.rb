# 赛程 APi

module Api
  class ScheduleController < BaseController

    def index
      render json:
        load_series, each_serializer: ScheduleSerializer, root: 'data', meta: meta
    end

    def show
      load_single_series
      render json: 
        @single_series, serializer: SeriesSerializer, root: 'data'
    end

    private
      def unsort_series
        MatchSeries.select(needed_column).non_hidden.non_pending.with_game(game_id).includes(:league, :left_team, :right_team)
      end

      def load_series
        @load_series ||= unsort_series.order(start_time: :desc).page(current_page).per(per_page)
      end

      def game_id
        params.fetch(:game_id, 1)
      end

      def load_single_series
        @single_series ||= MatchSeries.find_by(id: params[:id])
        raise SeriesNotFoundError unless @single_series
      end

      def needed_column
        [:id, :left_team_id, :right_team_id, :game_id, :round, :start_time, :league_id, :status]
      end

      def meta
        {
          current_page: current_page,
          per: per_page,
          total_page: MatchSeries.non_hidden.non_pending.with_game(game_id).count
        }
      end
  end
end
