module Api
  class LiveController < BaseController

    def index
      render json:
        load_series, each_serializer: LiveListSerializer, root: 'data', meta: meta
    end

    # Live详情 & 传入参数是当前的需要查看的 SeriesID
    def show
      load_single_series
      
      if @series.ongoing?
        api_path = "http://api.ouresports.com/api/v2/live/dota/#{@series.id}?game_no=#{game_no}"
      elsif @series.finished?
        api_path = "http://api.ouresports.com/api/v2/live/dota/#{@series.id}?game_no=#{game_no}"
      end

      request = Typhoeus::Request.new(
        api_path,
        method: :get,
        headers: { Accept: "text/html" }
      )
      resp = request.run
      render_data = { data: JSON.parse(resp.body)['match'].merge(
        {
          game_no: game_no
        }
      )}
      render json: render_data
    end


    def game_no
      return (@series.left_score + @series.right_score) if @series.finished?
      @series.left_score + @series.right_score + 1
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
        # raise SeriesNotLivingError unless @series.ongoing?
      end

      def load_match
        @match ||= @series.current_match
        raise CurrentMatchNotFoundError unless @match
        raise CurrentMatchNotOnGoingError if (@match.status != 1) # 若不是在进行中 就直接返回
      end

      def load_live
        load_dota_live
      end

      def load_dota_live
        @dota_live = ::Lives::Dota2.new(db_match: @match)
        @dota_live.exec(left_team_id, right_team_id)
      end

      def left_team_id
        @series.left_team.extern_id
      end

      def right_team_id
        @series.right_team.extern_id
      end

      def needed_column
        [:id, :left_team_id, :right_team_id, :game_id, :round, :start_time, :league_id, :status, :left_score, :right_score]
      end

      def meta
        basic_meta
      end

  end
end
