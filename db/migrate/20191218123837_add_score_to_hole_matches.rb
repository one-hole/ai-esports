class AddScoreToHoleMatches < ActiveRecord::Migration[6.0]
  def change
    add_column(:hole_matches, :left_score, :integer, default: 0)
    add_column(:hole_matches, :right_score, :integer, default: 0)
  end
end
