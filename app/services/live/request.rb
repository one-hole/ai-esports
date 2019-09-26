module Live
  class Request

    PATH = "https://api.steampowered.com/IDOTA2Match_570/GetLiveLeagueGames/v1"

    def self.run
      options = {timeout: 10, connecttimeout: 10 }.merge({
        params: params
      })
      request = Typhoeus::Request.new(PATH, options)
      request.run
    end

    private
    
    def self.params
      {
        key: get_key,
        format: "json"
      }
    end

    def self.get_key
      ["040FA36AB25776E7072B0B42CAB25A20", "A72DE7D7BE9870C8DA671D67941CCAA7"][rand(2)]
    end
  end
end

# 0A2CF904AF1E84C1B7403A9FBD677EB0