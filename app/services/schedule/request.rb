module Schedule
  class Request

    def self.get(url, opts)
      request = Typhoeus::Request.new(
        url,
        method:  :get
      )

      resp = request.run
    end
  end
end