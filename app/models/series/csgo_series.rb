class CsgoSeries < MatchSeries
  has_many :matches, foreign_key: 'series_id', class_name: 'CsgoMatch', dependent: :destroy
  has_one :banpick, as: :bpable

  def get_banpick
    self.banpick.presence || nil
  end
end
