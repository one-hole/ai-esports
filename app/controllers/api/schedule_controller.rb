# 赛程 APi

module Api
  class ScheduleController < BaseController

    def index
      render json: {
        data: "Cao NiMa"
      }
    end
  end
end
