module Schedule
  class Request

    def self.get(url, opts)
      request = Typhoeus::Request.new(
        url,
        method:  :get,
        headers: headers(opts),
        params:  params(opts)
      )

      resp = request.run
    end

    def self.headers(opts = {})
      {
        "Referer": "https://www.t2score.com/",
        "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:70.0) Gecko/20100101 Firefox/70.0"
      }
    end

    def self.params(opts = {})

    end
  end
end