module Api
  class PlayersController < BaseController
    
    def index
       @players = Player.page(current_page).per(per_page)
       render json: 
        @players, each_serializer: PlayerSerializer, root: 'data', meta: meta
    end


    private
      def meta
        {
          current_page: current_page,
          total_count: Player.count,
          per: per_page
        }.merge(basic_meta)
      end
  end
end