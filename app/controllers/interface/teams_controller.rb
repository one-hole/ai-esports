module Interface
  class TeamsController < BaseController
    def index
      teams = Embrace::Team.page(current_page).per(per_page)
      render json: teams, each_serializer: Interface::TeamIndex, root: 'data', meta: meta
    end

    private

      def meta
        {
          total_count: Embrace::Team.count,
          current_page: current_page,
          per_page: per_page
        }.merge(basic_meta)
      end
  end
end