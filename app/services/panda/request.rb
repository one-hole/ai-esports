module Panda
  class Request
    def self.get(url, page = 1, per_page = 50, options = {})
      resp = RestClient.get url, {
        params: {
          token: '87cs9CkVSn4KmwAEqqiq-h7spxdhT2_YiuwoDpbRVTfR6iHdpXA',
          page: page,
          per_page: per_page,
        }.merge(options)
      }
    end
  end
end