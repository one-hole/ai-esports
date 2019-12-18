class CsgoTeam < Hole::Team

  def team_names
    [self.abbr, self.name].compact.map { |item | item.downcase}
  end
end
