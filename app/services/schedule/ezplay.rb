module Schedule
  class Ezplay

    URL = "https://www.baidu.com"
    def initialize
      begin
        @resp = Request.get(URL, opts = {})
      rescue => e
        puts e
      end
    end
  end
end