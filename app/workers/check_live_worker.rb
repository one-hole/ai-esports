class CheckLiveWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'polling'

  def perform

    @redis = Redis.new(db: 12)
    load_ids.each do |pair|
      resp = ::DotaLiveService(pair[0], pair[1], pair[2], pair[3]).run
      @redis.publish("tenant-websocket", resp)
    end

    CheckLiveWorker.perform_in(15.seconds)
  end

  def load_ids
    MatchSeries.select([:id, :round]).for_live_index(1).pluck(:id, :round, :left_score, :right_score)
  end


end
