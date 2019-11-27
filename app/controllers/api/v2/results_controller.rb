module Api
  module V2
    class ResultsController < BaseController

      def show
        load_match
        render json:
          @match
      end


      private
      def load_match
        @match = Dota2Match.eager_load(:detail).find_by(battle_id: params[:battle_id], game_no: params[:game_no])
      end
    end
  end
end