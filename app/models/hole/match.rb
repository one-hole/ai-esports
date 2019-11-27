class Hole::Match < ApplicationRecord
  has_one    :detail, class_name: "MatchDetail"
  belongs_to :battle

  after_create_commit do
    ensure_detail
  end

  def ensure_detail
    self.create_detail
  end
end