module SeriesKlassConcern
  def series_klass(game_id)
    if game_id == 1
      return "Dota2Series".constantize
    elsif game_id == 2
      return "CsgoSeries".constantize
    elsif game_id == 3
      return "LolSeries".constantize
    elsif game_id == 4
      return "KogSeries".constantize
    end
  end
end