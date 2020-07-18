module Interface
  class TournamentIndex < ActiveModel::Serializer
    attribute :id
    attribute :game_id
    attribute :name
    attribute :begin_at
    attribute :end_at

    belongs_to :series, serializer: SeriesIndex
    belongs_to :league, serializer: LeagueIndex
  end
end