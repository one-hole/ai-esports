# encoding: utf-8

module Fetch
  class Dota2MatchDetailWorker

    include Sidekiq::Worker
    sidekiq_options queue: 'fetch-match-detail',
                    retry: false,
                    on_conflict: :reject,
                    lock: :until_and_while_executing,
                    unique_args: :unique_args


    def self.unique_args(args)
      [args[0]]
    end

    def perform(match_id)
      match = Dota2Match.find_by(id: match_id)

      if match
        match.fetch_detail
      end
    end
  end
end

# Fetch::Dota2MatchDetailWorker.perform_async(1)
