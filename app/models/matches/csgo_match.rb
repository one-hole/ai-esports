class CsgoMatch < Hole::Match

  has_one :detail, foreign_key: "match_id", class_name: "CsgoMatchDetail"
  delegate :first_half_left_t, :left_win_five,:left_win_1, :left_win_16, :first_half_left_score, :first_half_right_score, :second_half_left_score, :second_half_right_score, :map, to: :detail, allow_nil: true

  after_create_commit do
    ensure_detail
  end

  def ensure_detail
    self.create_detail
  end

  def over?
    if (left_score + right_score) <= 30
      if left_score >= 16 || right_score >= 16
        return true
      end
    else # 需要判定打了几个加时
      over_score = left_score + right_score - 30
      over_count = (over_score.to_f / 6.to_f).floor

      left_score  = left_score - 15 - over_count * 3
      right_score = right_score - 15 - over_count * 3

      if (left_score >= 4 || right_score >=4)
        return true
      end
    end
    return false
  end
end

# 总局数小于 30 的时候 有一方达到 16
# 总局数大于 30 的时候 - 30
