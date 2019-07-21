module Api
  class TopicsController < BaseController

  # 按照日期查询
  # 分页参数
  # 游戏参数

  def index
    check_params
    load_series
    render json: 
      @match_series, each_serializer: TopicSerializer, root: 'data'
  end

  private
    def load_series
      @match_series ||= MatchSeries.with_date(@date).with_game(params["game_id"]).includes(:all_topics, :bet_topics)
    end

    def check_params
      (@date = Date.parse(params["date"])) rescue raise DateParamsError
      raise GameIDError if params["game_id"] == nil
    end
  end
end
