# encoding: utf-8

module Fetch
  class T2TeamWorker

    include Sidekiq::Worker
    sidekiq_options queue: 'fetch-info', retry: false

    def perform(hole_team_id)
      team = Hole::Team.find_by(id: hole_team_id)
      team.fetch_t2
    end
  end
end