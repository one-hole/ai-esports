module Interface
  class BattlesController < BaseController

    def index
      battles = Embrace::Battle.all
      render json:
        battles, root: 'data'
    end
  end
end