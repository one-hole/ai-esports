module Live
  class CleanOhmsService
    def self.start
      now = Time.now

      Ohms::Battle.all.each do |battle|
        battle.destroy
      end

    end
  end
end