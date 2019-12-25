class Dota2Team < Hole::Team
  
  def info
    [(self.name.downcase rescue nil), (self.abbr.downcase rescue nil), self.official_id.to_i]
  end
end
