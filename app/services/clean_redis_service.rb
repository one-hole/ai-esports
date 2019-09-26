class CleanRedisService

  def self.start
    now = Time.now

    # 最后更新时间是 15 分钟之前 那么就删除
    Live::Battle.all.each do |battle|
      if (now - battle.updated_at.to_time) >= 900
        battle.destory
      end
    end

  end
end