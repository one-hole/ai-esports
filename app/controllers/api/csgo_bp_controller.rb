module Api
  class CsgoBpController < BaseController

    def show
      load_bp
      if load_bp
        render json:
          @banpick, serializer: CsgoBpSerializer, root: 'data', adapter: :json
      else
        render json: {
          message: 'Now, We do not have bp infos'
        }
      end
    end

    private
      def load_series
        @csgo_series = CsgoSeries.find_by(id: params[:id])
        if !@csgo_series
          render json: { error: 'Series Not exists' }
        end
      end

      def load_bp
        @banpick = load_series.get_banpick
      end
  end
end
