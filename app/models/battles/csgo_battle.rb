class CsgoBattle < Hole::Battle

  after_create_commit do
    build_matches
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