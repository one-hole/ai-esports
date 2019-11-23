class AddStartAtToBattles < ActiveRecord::Migration[5.2]
  def change
    add_column :hole_battles, :start_at, :datetime
    add_column :hole_battles, :left_score, :integer
    add_column :hole_battles, :right_score, :integer
  end
end
