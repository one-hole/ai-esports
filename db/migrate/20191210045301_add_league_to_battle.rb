class AddLeagueToBattle < ActiveRecord::Migration[6.0]
  def change
    add_column(:hole_battles, :league_id, :integer)
    add_index(:hole_battles, :league_id, name: 'idx_league_battle')
  end
end
