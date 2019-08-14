class CheckLiveWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'polling'

  def perform

    @redis = Redis.new(db: 12)
    load_ids.each do |pair|
      resp = ::DotaLiveService.new(pair[0], pair[1], pair[2], pair[3]).run
      @redis.publish("aiesports-dota2-websocket", resp)
      @redis.sadd("new-player-ids", load_players(resp))
    end

    CheckLiveWorker.perform_in(3.seconds)
  end

  def load_ids
    MatchSeries.select([:id, :round]).for_live_index(1).pluck(:id, :round, :left_score, :right_score)
  end

  def load_players(resp)
    player_ids = []
    new_data = JSON.parse(resp)["matches"][0]["data"]
    new_data["left_players"].each do |player|
      player_ids << player["account_id"]
    end
    new_data["right_players"].each do |player|
      player_ids << player["account_id"]
    end
    return player_ids
  end


end
