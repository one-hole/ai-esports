# dota2 live模块的入口
#
module Dota2Live
  class FetcherService

    extend Dota2Live::Util
    extend Dota2Live::Db::Dota2Match

    def self.exec
      begin
        retries ||= 0
        puts '-------------------------------------'
        puts "#{Time.now} Start of Fetcher Service round: #{retries + 1}"
        puts '-------------------------------------'

        get

        puts '-------------------------------------'
        puts "#{Time.now} End of current Fetcher Service"
        puts '-------------------------------------'
      rescue Net::OpenTimeout, Net::ReadTimeout, OpenSSL::SSL::SSLError => e
        puts e
      rescue => e
        puts e
        puts e.backtrace
        Raven.capture_exception(e)
        retry if (retries += 1) < 3
      end
    end

    private

    def self.get
      # -----------------------------------------------------------------------------
      # 数据获取部分
      # -----------------------------------------------------------------------------
      base_uri = "https://api.steampowered.com/IDOTA2Match_570/GetLiveLeagueGames/v1"
      options = { query: { key: ENV['STEAM_KEY'], format: 'xml' } }
      respond = HTTParty.get(base_uri, options)
      if respond['result'].nil? || respond['result']['games'].nil?
        puts "[EMPTY] games list empty"
        return
      end
      games = respond['result']['games']['game']

      # -----------------------------------------------------------------------------
      # 数据处理开始
      # -----------------------------------------------------------------------------
      process(games.select{|game| valid_game?(game)})
    end

    def self.process(valid_games)
      puts "valid games to process: #{valid_games.map{|game| game['match_id'].to_s}}"
      puts "live match ids #{live_match_ids}"

      # -----------------------------------------------------------------------------
      # 处理已结束比赛
      # -----------------------------------------------------------------------------
      process_finished_matches(valid_games)

      # -----------------------------------------------------------------------------
      # 处理进行中比赛
      # -----------------------------------------------------------------------------
      process_cur_matches(valid_games)
    end

  end
end

# Dota2Live::FetcherService.exec