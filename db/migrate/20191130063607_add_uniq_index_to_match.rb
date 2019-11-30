class AddUniqIndexToMatch < ActiveRecord::Migration[6.0]
  def change
    remove_index(:hole_matches, name: "index_hole_matches_on_battle_id")
    add_index(:hole_matches, [:battle_id, :game_no], unique: true, name: 'idx_uniq_bat_game_on_match')
    add_index(:hole_matches, [:type, :official_id],  unique: true, name: 'idx_uniq_typ_ofid_on_match')
  end
end
