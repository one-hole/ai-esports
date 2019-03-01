class CheckLiveWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'polling'

  def perform
    
    load_ids.each do |pair|
      DotaLiveService(pair[0], pair[1], pair[2], pair[3])
    end

    CheckLiveWorker.perform_in(15.seconds)
  end
  
  def load_ids
    MatchSeries.select([:id, :round]).for_live_index(1).pluck(:id, :round, :left_score, :right_score)
  end


end