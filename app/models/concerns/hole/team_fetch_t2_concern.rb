module Hole
  module TeamFetchT2Concern
    extend ActiveSupport::Concern

    included do
      # 只有 T2 创建的战队才会调用这个方法
      def fetch_t2
        resp = Typhoeus.get("https://www.t2score.com/api/front/team/#{self.trdid.split("_")[1]}")
        begin
          info = JSON.parse(resp.body)
          self.update(
            name:     info["name"],
            country:  info["country_code"],
          )
        rescue
          nil
        end
      end

      def fetch_t2_async
        Fetch::T2TeamWorker.perform_async(self.id)
      end
    end
  end
end