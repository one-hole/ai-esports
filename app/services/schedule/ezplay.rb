module Schedule
  class Ezplay

    include EzplayDota2

    def run
      fetch_ongoing
      fetch_upcoming
      merge_battles

      process_dota2s
      process_csgos
    end

    private

    def request(url)
      resp = RestClient::Request.execute(
        url: url,
        method: :get,
        timeout: 20
      )
      return resp
    end

    def process_dota2s

      @dota2s.each do |battle|
        if "start" == battle["state"]
          process_start_dota2(battle)
        else
          process_upcoming_dota2(battle)
        end
      end

    end

    def process_csgos
    end

    def merge_battles
      @dota2s = @ongoing_dota2 + @upcoming_dota2
      @csgos  = @ongoing_csgo + @upcoming_csgo
    end

    def get_timestamp
      return (Time.now.to_f * 1000).to_i
    end

    def fetch_ongoing
      begin
        @origin_ongoing = JSON.parse(request("https://1zplay.com/api/live_schedules?_=#{get_timestamp}&category=all"))
        @ongoing_dota2  = @origin_ongoing.select { |item| item["category"] == "dota2" }
        @ongoing_csgo   = @origin_ongoing.select { |item| item["category"] == "csgo" }
      rescue
        @ongoing_dota2 = []
        @ongoing_csgo  = []
      end
    end

    def fetch_upcoming
      begin
        @origin_upcoming = JSON.parse(request("https://1zplay.com/api/upcoming_schedules?_=#{get_timestamp}&category=all"))
        @upcoming_dota2   = @origin_upcoming.select { |item| item["category"] == "dota2" }
        @upcoming_csgo    = @origin_upcoming.select { |item| item["category"] == "csgo" }
      rescue
        @upcoming_dota2 = []
        @upcoming_csgo  = []
      end
    end

    def fetch_finished

    end

  end
end