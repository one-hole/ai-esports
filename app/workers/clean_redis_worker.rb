class CleanRedisWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    begin
      CleanRedisService.start
    ensure
      CleanRedisWorker.perform_in(15.minutes)
    end
  end
end