module Api
  class LeaguesController < BaseController

    def index
      load_leagues
      render json:
        @leagues, each_serializer: LeagueListSerializer, root: 'data', meta: meta
    end

    private
      def load_leagues
        @leagues ||= League.significant.no_hidden.with_game(game_id).order(start_time: :desc).page(current_page).per(30)
      end

      def game_id
        params.fetch(:game_id, nil)
      end

      def meta
        {
          current_page: current_page,
          per: 30,
          total_count: League.significant.no_hidden.with_game(game_id).count
        }.merge(basic_meta)
      end
  end
end
