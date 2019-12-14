class CsgoMatch < Hole::Match

  has_one :detail, foreign_key: "match_id", class_name: "CsgoMatchDetail"
  delegate :first_half_left_t, :left_win_five,:left_win_1, :left_win_16, :first_half_left_score, :first_half_right_score, :second_half_left_score, :second_half_right_score, :map, to: :detail

  after_create_commit do
    ensure_detail
  end

  def ensure_detail
    self.create_detail
  end
end
