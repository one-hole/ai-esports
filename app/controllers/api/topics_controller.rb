module Api
  class TopicsController < BaseController

  # 按照日期查询
  # 分页参数
  # 游戏参数

  def index
    check_params
    render json: {
      "data": true
    }
  end

  private
    def load_series
      @match_series ||= MatchSeries.with_date(params["date"]).with_game(params["game_id"])
    end

    def check_params
      Date.parse(params["date"]) rescue raise DateParamsError
      raise GameIDError if params["game_id"] == nil
    end
  end
end
