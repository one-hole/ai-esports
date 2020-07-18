module SeriesKlassConcern
  def series_klass(game_id)
    case game_id
    when 1
      return "Dota2Series".constantize
    when 2
      return "CsgoSeries".constantize
    when 3
      return "LolSeries".constantize
    when 4
      return "KogSeries".constantize
    end
  end
end