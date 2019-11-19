# encoding: utf-8

module Live
  class Dota2LeagueWorker

    include Sidekiq::Worker
    sidekiq_options queue: 'live-league', retry: false

    def perform
      begin
        Live::Leagues::Exec.start
      ensure
        Live::Dota2LeagueWorker.perform_in(10.seconds)
      end
    end
  end
end