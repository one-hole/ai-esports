# 非过滤赛程 APi

module Api
  class NonsigScheduleController < BaseController

    def index
      render json:
        load_series, each_serializer: ScheduleSerializer, root: 'data', meta: meta
    end

    private
      def unsort_series
        if date
          MatchSeries.non_pending.with_game(game_id).with_date(date).includes(:league, :left_team, :right_team)
        else
          MatchSeries.non_pending.with_game(game_id).includes(:league, :left_team, :right_team)
        end
      end

      def date
        Date.parse(params[:date]) rescue nil
      end

      def load_series
        if date
          @load_series ||= unsort_series.order(start_time: :desc)
        else
          @load_series ||= unsort_series.order(start_time: :desc).page(current_page).per(per_page)
        end
      end

      def game_id
        params.fetch(:game_id, 1)
      end

      # def needed_column
      #   [:id, :left_team_id, :right_team_id, :game_id, :round, :start_time, :league_id, :status, :type]
      # end

      def meta
        {
          current_page: current_page,
          per: per_page,
          total_count: MatchSeries.non_pending.with_game(game_id).count
        }.merge(basic_meta)
      end
  end
end