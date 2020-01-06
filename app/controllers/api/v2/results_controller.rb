module Api
  module V2
    class ResultsController < BaseController

      def show
        load_match
        render json:
          @match, serializer: ::V2::ResultsIndexSerializer, root: 'data'
      end


      private
      def load_match
        @match = Dota2Match.eager_load(:detail, [battle: [:left_team, :right_team]]).where(battle_id: params[:battle_id], game_no: params[:game_no]).last
        raise CurrentMatchNotStart unless @match
        raise CurrentMatchNotStart if not_start
      end

      def not_start
        @battle = @match.battle

        if @battle.format == 3
          if @battle.left_score == 2 && @battle.right_score == 0
            return true
          end

          if @battle.left_score == 0 && @battle.right_score == 2
            return true
          end
        end

        if @battle.format == 5
          if (@battle.left_score - @battle.right_score).abs == 3
            return true
          end
        end

        return false
      end
    end
  end
end

# 如果是 BO3 那么