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
        raise CurrentMatchNotStart if not_start
      end

      def not_start
        @battle = @match.battle

        if @battle.format == 3 && @match.game_no == 3
          if @battle.left_score == 2 && @battle.right_score == 0
            return true
          end

          if @battle.left_score == 0 && @battle.right_score == 2
            return true
          end
        end

        if @battle.format == 5
          if @battle.left_score == 3 && @battle.right_score == 0 && (@match.game_no == 4 || @match.game_no == 5)
            return true
          end

          if @battle.left_score == 0 && @battle.right_score == 3 && (@match.game_no == 4 || @match.game_no == 5)
            return true
          end

          if @battle.left_score == 3 && @battle.right_score == 1 && @match.game_no == 5
            return true
          end

          if @battle.left_score == 1 && @battle.right_score == 3 && @match.game_no == 5
            return true
          end
        end

        return false
      end
    end
  end
end