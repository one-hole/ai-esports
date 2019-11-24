module Schedule
  class Request

    def self.get(url, opts)
      request = Typhoeus::Request.new(
        url,
        method:  :get,
        params:  params(opts)
      )

      resp = request.run
    end

    def self.params(opts = {})

    end
  end
end