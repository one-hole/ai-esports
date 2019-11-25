module Schedule
  class Request

    def self.get(url, opts)
      request = Typhoeus::Request.new(
        url,
        method:  :get,
        params:  params(opts),
        headers: {
          "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:70.0) Gecko/20100101 Firefox/70.0"
        }
      )

      resp = request.run
    end

    def self.params(opts = {})

    end
  end
end