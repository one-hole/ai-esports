require_relative "process"
require_relative "request"

module Live
  module Tops
    class Exec

      extend Process

      def self.start
        resp = Request.run
        battles = JSON.parse(resp.body)["game_list"]
        process(battles)
        return nil
      end
    end
  end
end


# Live::Tops::Exec.start