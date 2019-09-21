module Api
  module V2
    class LivesController < BaseController
      def index
        render json: {
          abbr: "json"
        }
      end

      def show
      
      end
    end
  end
end