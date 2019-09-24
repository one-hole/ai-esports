class FakerV2Worker
  include Sidekiq::Worker

  def perform
    FakeLiveV2Service.new.run
    FakerV2Worker.perform_in(15.seconds)
  end
end