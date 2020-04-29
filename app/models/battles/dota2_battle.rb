class Dota2Battle < Hole::Battle

  before_update do
    check_match_detail
  end

  scope :recent_3_hours, -> (t) {
    where("start_at <= ? && start_at >= ?", t + 90.minutes, t - 90.minutes)
  }

  def check_match_detail
    # 这里是比分有改变
    if self.changed.include?("left_score") or self.changed.include?("right_score")
      match = matches.where(game_no: (self.left_score + self.right_score)).last

      if match
        match.sync_detail
        match.async_fetch_detail
      end
    end

    # 这里是整个系列赛状态有改变
    # 全部 Fetch 一遍
    if self.changed.include?("status")

    end
  end
end