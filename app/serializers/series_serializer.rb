class SeriesSerializer < ActiveModel::Serializer
  attributes MatchSeries.attribute_names
end
