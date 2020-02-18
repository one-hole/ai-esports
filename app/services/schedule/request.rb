module Schedule
  class Request

    def self.get(url)
      begin
        resp = RestClient::Request.execute(
          url: "https://api.tuotugame.com/api/front/schedule/schedule_three_days",
          method: :get,
          timeout: 20
        )
        return resp
      rescue => e
        $tuotu_logger.error(e)
      end

    end
  end
end