module Api
  module Constants
    class LolHeroesController < BaseController

      def index
        render json:
          load_heroes, each_serializer: LolHeroSerializer, root: 'data', meta: basic_meta
      end

      def show
        render json:
          load_hero, serializer: LolHeroShowSerializer, root: 'data', meta: basic_meta
      end

      private
        def load_heroes
          LolConstant::Hero.all
        end

        def load_hero
          LolConstant::Hero.find_by(id: params[:id])
        end
    end
  end
end
