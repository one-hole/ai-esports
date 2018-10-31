module Api
  class ResultsController < BaseController

    include SeriesKlassConcern

    def index
      render json:
        load_series, each_serializer: ResultListSerializer, root: 'data', meta: meta
    end

    # 默认给最后一场
    def show
      load_single_series
      load_match

      url = "http://api.ouresports.com/api/v2/live/dota/#{@single_series.id}?game_no=#{game_no}"
      request = Typhoeus::Request.new(
        url,
        method: :get,
        headers: { Accept: "text/html" }
      )
      resp = request.run
      render json: { data: JSON.parse(resp.body)['match'], meta: basic_meta}
    end

    private
      def unsort_series
        series_klass(game_id).select(needed_column).for_result_index(game_id).includes(:league, :left_team, :right_team, :matches)
      end

      def load_series
        @load_series ||= unsort_series.page(current_page).per(per_page)
      end

      def load_single_series
        @single_series ||= MatchSeries.find_by(id: params[:id].to_i)
        raise SeriesNotFoundError unless @single_series
      end

      def load_match
        @match ||= @single_series.matches.find_by(game_no: game_no)
        raise CurrentMatchNotFinishedError if (@match.status != 2)
      end

      def game_no
        params.fetch(:game_no, 1).to_i
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
