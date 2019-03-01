class CheckLiveWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'polling'

  def perform
    

    CheckLiveWorker.perform_in(15.seconds)
  end

end