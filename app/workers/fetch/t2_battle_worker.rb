# encoding: utf-8

module Fetch
  class T2BattleWorker
    include Sidekiq::Worker
    sidekiq_options queue: 'fetch-battle', retry: false

    def perform
      begin
        Schedule::T2score.new
      ensure
        Fetch::T2BattleWorker.perform_in(10.seconds)
      end
    end
  end
end


# 经济经验差直接从 LiveLeagueGame 出最好