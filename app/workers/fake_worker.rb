class FakeWorker
  include Sidekiq::Worker

  def perform
    @redis = Redis.new(db: 12)
    resp = ::FakeLiveService.new(259189, 2).run
    @redis.publish("aiesports-dota2-websocket", resp)

    FakeWorker.perform_in(10.seconds)
  end
end