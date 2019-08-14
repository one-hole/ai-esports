class FetchPlayersWorker
  include Sidekiq::Worker

  def perform
    Fetch::Player.new.run

    FetchPlayersWorker.perform_in(120.seconds)
  end
end
