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
        @match = Dota2Match.eager_load(:detail, [{ battle: [:left_team, :right_team] }]).where(battle_id: params[:battle_id], game_no: params[:game_no]).last
        raise CurrentMatchNotStart unless @match
      end


    end
  end
end

# 如果是 BO3 那么