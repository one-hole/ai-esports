module Live
  module Realtime
    class Request

      PATH = "https://api.steampowered.com/IDOTA2MatchStats_570/GetRealtimeStats/v1"

      def self.run(server_steam_id)
        options = { timeout: 10, connecttimeout: 10 }.merge({params: params.merge({server_steam_id: server_steam_id})})
        request = Typhoeus::Request.new(PATH, options)
        resp = request.run
      end

      def self.params
        {
          key: get_key,
          include_persona_names: true
        }
      end

      def self.get_key
        %w(040FA36AB25776E7072B0B42CAB25A20 A72DE7D7BE9870C8DA671D67941CCAA7
           0A2CF904AF1E84C1B7403A9FBD677EB0 97A9595BD1E33952EFDB2C5AD471CB8E
           D448ED9D73DC1ED1FEBCC1DC1DE83209 6481130831D1ECAF2932F006EB2E00FA)[rand(6)]
      end
    end
  end
end