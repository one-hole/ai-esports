module Interface
  class TeamsController < BaseController
    def index
      teams = Embrace::Team.page(current_page).per(per_page)
      render json:
        teams, each_serializer: Interface::TeamIndex, root: 'data', meta: meta
    end

    private

    def filter_params
      params.permit(:game)
    end

    def meta
      {
        total_count: Embrace::Team.filters(filter_params).count,
        current_page: current_page,
        per_page: per_page
      }.merge(basic_meta)
    end
  end
end