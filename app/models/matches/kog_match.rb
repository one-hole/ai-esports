class KogMatch < ApplicationRecord
  include ArcWardenDbConcern
  self.table_name = "kog_matches"

  belongs_to :series, class_name: "KogSeries", foreign_key: :series_id
end
