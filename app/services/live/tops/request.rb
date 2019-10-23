module Live
  class Tops::Request < Request
    PATH = "https://api.steampowered.com/IDOTA2Match_570/GetTopLiveGame/v1"

    def self.run
      options = {timeout: 10, connecttimeout: 10 }.merge({
        params: params
      })
      request = Typhoeus::Request.new(PATH, options)
      request.run
    end

    def self.params
      {
        key: get_key,
        format: "json",
        language: "zh_CN",
        partner: get_partner
      }
    end

    def self.get_partner
      [0, 1, 2, 3][rand(4)]
    end
  end 
end