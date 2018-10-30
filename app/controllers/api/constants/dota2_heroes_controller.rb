module Api
  module Constants
    class Dota2HeroesController < BaseController

      def index
        load_heroes
        render json:
          @heroes, each_serializer: Dota2HeroSerializer, root: 'data', meta: meta
      end

      private
        def load_heroes
          @heroes = Dota2Constant::Hero.page(current_page).per(10)
        end

        def meta
          {
            current_page: current_page,
            per: per_page,
            total_count: Dota2Constant::Hero.count
          }.merge(basic_meta)
        end
    end
  end
end
