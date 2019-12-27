module Api
  module V2
    class CsgoResultsController < BaseController
      def show
        load_match
        render json:
          @match, serializer: ::V2::CsgoResultsIndexSerializer, root: 'data'
      end

      private

      def load_match
        @match = CsgoMatch.where(battle_id: params[:battle_id], game_no: params[:game_no]).last
        raise CurrentMatchNotStart unless @match
        raise CurrentMatchNotStart if (0 == (@match.left_score + @match.right_score))
      end
    end
  end
end