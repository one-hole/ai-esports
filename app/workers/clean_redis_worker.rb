class CleanRedisWorker
  include Sidekiq::Worker

  def perform
    begin
      CleanRedisService.start
    ensure
      CleanRedisWorker.perform_in(15.minutes)
    end
  end
end