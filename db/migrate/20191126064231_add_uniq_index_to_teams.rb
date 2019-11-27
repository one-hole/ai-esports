# TODO 这个 Migration 并没有跑

class AddUniqIndexToTeams < ActiveRecord::Migration[6.0]
  def change
    # add_index :hole_teams, [:type, :official_id], unique: true, name: 'uniq_type_and_id_on_teams'
  end
end
