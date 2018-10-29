# 整体的获取各项数据的入口
#
module Dota2Live
  module Db
    module Getter

      include DbGetter
      include RedisGetter

    end
  end
end