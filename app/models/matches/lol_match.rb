class LolMatch < ApplicationRecord
  include ArcWardenDbConcern
  self.table_name = "lol_matches"

  belongs_to :series, class_name: "LolSeries", foreign_key: :series_id
end
