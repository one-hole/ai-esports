module Interface
  class GamesController < BaseController

    def index
      games = Embrace::Game.all
      render json:
        games, each_serializer: GameIndex, root: 'data'
    end
  end
end