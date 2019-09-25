class FakerV2Worker
  include Sidekiq::Worker

  sidekiq_options queue: 'live'

  def perform
    begin
      FakeLiveV2Service.new.run
    ensure
      FakerV2Worker.perform_in(15.seconds)
    end
  end
end
