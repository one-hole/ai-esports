# 赛果 APi

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
      url = ""
      if @single_series.type == "Dota2Series"
        url = "http://api.ouresports.com/api/v2/live/dota/#{@single_series.id}?game_no=#{game_no}"
      elsif @single_series.type == "CsgoSeries"
        url = "http://api.ouresports.com/web/live/csgo/#{@single_series.id}?game_no=#{game_no}"
      end
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
        if date
          series_klass(game_id).select(needed_column).finished.non_hidden.with_date(date).includes(:league, :left_team, :right_team, :matches)
        else
          series_klass(game_id).select(needed_column).for_result_index(game_id).includes(:league, :left_team, :right_team, :matches)
        end
      end

      def load_series
        if date
          @load_series ||= unsort_series
        else
          @load_series ||= unsort_series.page(current_page).per(per_page)
        end
      end

      def date
        Date.parse(params[:date]) rescue nil
      end

      def load_single_series
        @single_series ||= MatchSeries.find_by(id: params[:id].to_i)
        raise SeriesNotFoundError unless @single_series
      end

      def load_match
        @match ||= @single_series.matches.find_by(game_no: game_no)
        # raise CurrentMatchNotFinishedError if (@match.status != 2)
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
