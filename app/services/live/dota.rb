module Live
  class Dota
    extend Util

    def self.start
      resp = Request.run
      battles = JSON.parse(resp.body)["result"]["games"]
      process(battles.select { |battle| valid_battle?(battle) })
    end

    def self.process(battles)
      binding.pry
    end
  end
end