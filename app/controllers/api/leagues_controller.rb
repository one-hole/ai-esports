module Api
  class LeaguesController < BaseController

    def index
      load_leagues
      render json:
        @leagues, each_serializer: LeagueListSerializer, root: 'data', meta: meta
    end

    def show
      render json:
        load_league, serializer: LeagueSerializer, root: 'data', meta: basic_meta
    end

    private
      def load_leagues
        @leagues ||= League.no_hidden.with_game(game_id).order(start_time: :desc).page(current_page).per(30)
      end

      def load_league
        League.find_by(id: params[:id])
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
