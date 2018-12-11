class CsgoMatch < ApplicationRecord
  include ArcWardenDbConcern
  self.table_name = "csgo_matches"

  belongs_to :series, class_name: "CsgoSeries", foreign_key: :series_id
end
