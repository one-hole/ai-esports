module Fetch
  class Player

    def run
      @redis = Redis.new(db: 12)

      url = "https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v2"
      keys = ["040FA36AB25776E7072B0B42CAB25A20", "A72DE7D7BE9870C8DA671D67941CCAA7"]
      

      account_ids = @redis.srandmember("new-player-ids", 50)

      steamids = ""
      account_ids.each do |account_id|
        steamid = account_id.to_i + 76561197960265728
        steamids = "#{steamids}#{steamid},"
      end

      path = "#{url}?key=#{keys[rand(10) % 2]}&steamids=#{steamids}"

      response = Typhoeus.get(path)

      JSON.parse(response.body)["response"]["players"].each do |playinfo|
        account_id = playinfo["steamid"].to_i - 76561197960265728

        player = ::Player.find_or_create_by(account_id: account_id)
        player.update_columns(
          {
            personaname: playinfo["personaname"],
            avatar:      playinfo["avatarfull"]
          }
        )
      end

      @redis.srem("new-player-ids", account_ids) if (account_ids.size > 0)

    end
  end
end


      # t.string :personaname
      # t.string :officalname
      # t.bigint :account_id,  comment: "Steam ID -> account_id"
      # t.string :avatar