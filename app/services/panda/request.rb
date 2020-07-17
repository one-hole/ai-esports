module Panda
  class Request
    def self.get(url, page = 1)
      resp = RestClient.get url, {
        params: {
          token: '87cs9CkVSn4KmwAEqqiq-h7spxdhT2_YiuwoDpbRVTfR6iHdpXA',
          page: page,
          per_page: 50,
        }
      }
    end
  end
end