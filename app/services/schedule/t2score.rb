module Schedule
  class T2score

    URL = "https://www.t2score.com/api/front/schedule/schedule_three_days"

    def self.run
      resp = Request.get(URL, {})

      binding.pry
    end


  end
end