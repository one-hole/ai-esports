module Interface
  class LeaguesController < BaseController
    def index
      leagues = Embrace::League.page(current_page).per(per_page)
      render json:
               leagues, each_serializer: Interface::LeagueIndex, root: 'data', meta: meta
    end

    private

    def meta
      {
        total_count: Embrace::League.count,
        current_page: current_page,
        per_page: per_page
      }.merge(basic_meta)
    end
  end
end