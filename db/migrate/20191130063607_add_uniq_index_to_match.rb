class AddUniqIndexToMatch < ActiveRecord::Migration[6.0]
  def change
    add_index(:hole_matches, [:type, :battle_id, :official_id, :game_no],  unique: true, name: 'idx_uniq_typ_ofid_on_match')
  end
end
