module Api
  class TeamvsController < BaseController

    # before_action :check
    def show
      load_series
      url = ""
      if @series.type == "Dota2Series"
        url = "http://api.ouresports.com/api/v2/ai/dota2?left_team_id=#{@series.left_team_id}&right_team_id=#{@series.right_team_id}"
      elsif @series.type == "CsgoSeries"
        url = "http://api.ouresports.com/web/ai/csgo?left_team_id=#{@series.left_team_id}&right_team_id=#{@series.right_team_id}"
      end

      request = Typhoeus::Request.new(
        url,
        method: :get,
        headers: { Accept: "text/html" }
      )
      resp = request.run
      render json: { data: JSON.parse(resp.body)['stats'] }, status: 200

    end

    private
      def load_series
        @series = MatchSeries.find_by(id: params[:id])
        raise SeriesNotFoundError unless @series
      end

    # private
    #   def load_first_team
    #   end
    #
    #   def load_second_team
    #   end
    #
    #   def check
    #     check_team_params
    #     check_team_unsame
    #   end
    #
    #   def check_team_params
    #     raise TeamvsParamsError unless (params.fetch(:left_team_id, false) && params.fetch(:right_team_id, false))
    #   end
    #
    #   def check_team_unsame
    #     raise SameTeamError if (params.fetch(:left_team_id, false) == params.fetch(:right_team_id, false))
    #   end
  end
end
