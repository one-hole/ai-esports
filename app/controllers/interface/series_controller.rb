module Interface
  class SeriesController < BaseController
    def index
      series = Embrace::Series.page(current_page).per(per_page)
      render json:
               series, each_serializer: Interface::SeriesIndex, root: 'data', meta: meta
    end

    private

    def meta
      {
        total_count: Embrace::Series.count,
        current_page: current_page,
        per_page: per_page
      }.merge(basic_meta)
    end
  end
end