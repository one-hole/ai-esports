module Live
  class Dota

    extend Util::Validator
    extend Util::Process

    def self.start
      resp = Request.run
      begin
        battles = JSON.parse(resp.body)["result"]["games"]
        process(battles.select { |battle| valid_battle?(battle) })
      rescue => exception
        puts exception
      end
      return nil
    end

    def self.process(battles)
      
      puts "@----------------------------------------"
      puts "Current ids is #{battles.map { |battle| battle["match_id"] }}"
      puts "@----------------------------------------"
      @redis = Redis.new(db: 12)
      battles.each { |battle| process_currents(battle, @redis) }
    end
  end
end