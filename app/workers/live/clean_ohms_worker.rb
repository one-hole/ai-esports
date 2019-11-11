module Live
  class CleanOhmsWorker

    include Sidekiq::Worker
    sidekiq_options queue: "live-clean", retry: false

    def perform
      begin
        Live::CleanOhmsService.start
      ensure
        Live::CleanOhmsWorker.perform_in(5.minutes)
      end
    end
  end
end