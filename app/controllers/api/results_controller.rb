module Api
  class ResultsController < BaseController

    include SeriesKlassConcern

    def index
      render json:
        load_series, each_serializer: ResultListSerializer, root: 'data', meta: meta
    end

    private
      def unsort_series
        series_klass(game_id).select(needed_column).for_result_index(game_id).includes(:league, :left_team, :right_team, :matches)
      end

      def load_series
        @load_series ||= unsort_series.page(current_page).per(per_page)
      end

      def needed_column
        [:id, :left_team_id, :right_team_id, :game_id, :round, :start_time, :league_id, :status, :left_score, :right_score]
      end

      def meta
        {
          current_page: current_page,
          total_count: MatchSeries.for_result_index(game_id).count,
          per: per_page
        }.merge(basic_meta)
      end
  end
end
