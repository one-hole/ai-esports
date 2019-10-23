module Live
  module Tops
    class Exec

      extend Util::Process

      def self.start
        resp = Request.run
        begin
          battles = JSON.parse(resp.body)["game_list"]
          process(battles)
        rescue => exception
          puts exception
        end
        return resp
      end
    end
  end
end
