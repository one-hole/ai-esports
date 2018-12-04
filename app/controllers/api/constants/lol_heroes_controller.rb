module Api
  module Constants
    class LolHeroesController < BaseController
      
      def index
        render json:
          load_heroes, each_serializer: LolHeroSerializer, root: 'data', meta: basic_meta
      end

      private
        def load_heroes
          LolConstant::Hero.all
        end
    end 
  end
end