module Interface
  class TournamentsController < BaseController
    def index
      tournaments = Embrace::Tournament.all
      render json: tournaments
    end

    private

  end
end