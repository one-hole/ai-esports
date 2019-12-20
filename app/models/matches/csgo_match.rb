class CsgoMatch < Hole::Match

  has_one :detail, foreign_key: "match_id", class_name: "CsgoMatchDetail"
  delegate :first_half_left_t, :left_win_five,:left_win_1, :left_win_16, :first_half_left_score, :first_half_right_score, :second_half_left_score, :second_half_right_score, :map, to: :detail, allow_nil: true

  after_create_commit do
    ensure_detail
  end

  def ensure_detail
    self.create_detail
  end

  delegate :left_team, :right_team, to: :battle

  def handler(info)

    detail_round = JSON.parse(detail.info).fetch("data", nil).fetch("currentRound") rescue 1   # 已经存储的 Info
    info_round   = JSON.parse(info).fetch("data", nil).fetch("currentRound") rescue 0          # 等待处理的 Info
    
    return if (detail_round > info_round)

    # 1：判定哪边是 T & 如果这个不存在 那么进行处理
    if detail.first_half_left_t.nil?

      if left_team.team_names.include?(info["data"]["terroristTeamName"].downcase)
        if info["data"]["currentRound"] < 15
          detail.first_half_left_t = true
        elsif info["data"]["currentRound"] > 15
          detail.first_half_left_t = false
        end

        detail.save
      end

      if detail.first_half_left_t.nil?
        if right_team.team_names.include?(info["data"]["terroristTeamName"].downcase)
          if info["data"]["currentRound"] < 15
            detail.first_half_left_t = false
          elsif info["data"]["currentRound"] > 15
            detail.first_half_left_t = true
          end
        end
        detail.save
      end
    end

    # --------------------------- 函数内部分割线 ---------------------------
    # 2：更新比分
    #
    unless detail.first_half_left_t.nil?

      if detail.first_half_left_t == true
        left_first_log  = info["data"]["terroristMatchHistory"]["firstHalf"]
        left_second_log = info["data"]["ctMatchHistory"]["secondHalf"]

        right_first_log  = info["data"]["ctMatchHistory"]["firstHalf"]
        right_second_log = info["data"]["terroristMatchHistory"]["secondHalf"]

        left_score  = info["data"]["terroristScore"]
        right_score = info["data"]["counterTerroristScore"]
      else
        left_first_log  = info["data"]["ctMatchHistory"]["firstHalf"]
        left_second_log = info["data"]["terroristMatchHistory"]["secondHalf"]

        right_first_log  = info["data"]["terroristMatchHistory"]["firstHalf"]
        right_second_log = info["data"]["ctMatchHistory"]["secondHalf"]

        left_score  = info["data"]["counterTerroristScore"]
        right_score = info["data"]["terroristScore"]
      end

      self.update(
        left_score: left_score,
        right_score: right_score
      )
    end

    # 3：更新 Info
    if detail.info == nil
      detail.update(info: info.to_json)
    else
      detail_round = JSON.parse(detail.info).fetch("data", nil).fetch("currentRound") rescue 1
      info_round  = JSON.parse(info).fetch("data", nil).fetch("currentRound") rescue 0

      if detail_round < info_round
        detail.update(info: info.to_json)
      end
    end
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
