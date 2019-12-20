class CsgoBattle < Hole::Battle

  scope :no_official, -> { where(official_id: nil) }
  scope :for_hltv, -> { no_official.ongoing }

  after_create_commit do
    build_matches
  end

  def pre_match
    if format == 1
      return current_match
    end

    if 1 == current_game_no
      return current_match
    else
      return matches.find_by(game_no: (left_score + right_score))
    end
  end

  def build_matches
    (1..format).each do |i|
      matches.create(
        type:   'CsgoMatch',
        battle: self,
        game_no: i
      )
    end
  end
end