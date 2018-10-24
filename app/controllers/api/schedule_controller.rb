# 赛程 APi

module Api
  class ScheduleController < BaseController

    def index
      render json:
        load_series, each_serializer: ScheduleSerializer, fields: [:id, :left_team_id, :right_team_id], root: 'data', meta: meta
    end

    private
      def unsort_series
        @unsort_series ||= MatchSeries.select(needed_column).non_hidden.non_pending.with_game(game_id).includes(:left_team, :right_team)
      end

      def load_series
        @load_series ||= unsort_series.page(current_page).per(per_page)
      end

      def game_id
        params.fetch(:game_id, 1)
      end

      def needed_column
        [:id, :left_team_id, :right_team_id, :game_id]
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
