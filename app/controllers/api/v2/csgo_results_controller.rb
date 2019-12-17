module Api
  module V2
    class CsgoResultsController < BaseController
      def show
        load_match
        render json:
          @match
      end

      private

      def load_match
        @match = CsgoMatch.where(battle_id: params[:battle_id], game_no: params[:game_no]).last
        raise CurrentMatchNotStart unless @match
      end
    end
  end
end