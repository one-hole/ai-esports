module Api
  module Constants
    class Dota2AbilitiesController < BaseController
      def index
        load_abilities
        render json:
          @heroes, each_serializer: Dota2AbilitySerializer, root: 'data', meta: meta
      end

      def show
        render json:
          load_abilitiy, serializer: Dota2AbilitySerializer, root: 'data', meta: basic_meta
      end

      private
        def load_abilities
          @heroes = Dota2Constant::Ability.page(current_page).per(10)
        end

        def load_abilitiy
          @hero = Dota2Constant::Ability.find_by(steam_id: params[:id])
        end

        def meta
          {
            current_page: current_page,
            per: per_page,
            total_count: Dota2Constant::Ability.count
          }.merge(basic_meta)
        end
    end
  end
end
