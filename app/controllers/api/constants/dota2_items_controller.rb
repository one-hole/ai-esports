module Api
  module Constants
    class Dota2ItemsController < BaseController

      def index
        load_heroes
        render json:
          @heroes, each_serializer: Dota2ItemSerializer, root: 'data', meta: meta
      end

      def show
        render json:
          load_hero, serializer: Dota2ItemSerializer, root: 'data', meta: basic_meta
      end

      private
        def load_heroes
          @heroes = Dota2Constant::Item.page(current_page).per(10)
        end

        def load_hero
          @hero = Dota2Constant::Item.find_by(steam_id: params[:id])
        end

        def meta
          {
            current_page: current_page,
            per: per_page,
            total_count: Dota2Constant::Item.count
          }.merge(basic_meta)
        end
    end
  end
end
