module Live
  class Dota

    extend Util::Validator
    extend Util::Process

    def self.start
      resp = Request.run
      battles = JSON.parse(resp.body)["result"]["games"]
      process(battles.select { |battle| valid_battle?(battle) })
    end

    def self.process(battles)
      
      puts "@----------------------------------------"
      puts "Current ids is #{battles.map { |battle| battle["match_id"] }}"
      puts "@----------------------------------------"

      battles.each { |battle| process_currents(battle) }
    end
  end
end