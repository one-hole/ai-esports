class LiveMappingWorker
  include Sidekiq::Worker
  
  def perform
    begin
      Mapping::Dota2.new.run      
    ensure
      LiveMappingWorker.perform_in(3.seconds)
    end
  end
end