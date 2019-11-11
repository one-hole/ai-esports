module Live
  class Dota2TopWorker

    include Sidekiq::Worker
    sidekiq_options queue: "live-top", retry: false

    def perform
      begin
        Live::Tops::Exec.start
      ensure
        Live::Dota2TopWorker.perform_in(5.seconds)
      end
    end
  end
end

