module Interface
  class TournamentsController < BaseController
    def index
      tournaments = Embrace::Tournament.includes(:series, :league)
      render json:
        tournaments, each_serializer: Interface::TournamentIndex, root: 'data', meta: meta
    end

    private

    def meta
      {
        total_count: Embrace::Tournament.count,
        current_page: current_page,
        per_page: per_page
      }.merge(basic_meta)
    end

  end
end