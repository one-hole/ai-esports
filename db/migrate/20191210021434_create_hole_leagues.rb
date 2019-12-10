class CreateHoleLeagues < ActiveRecord::Migration[6.0]
  def change
    create_table :hole_leagues do |t|
      t.string :name
      t.string :name_en
      t.string :abbr
      t.string :sponsor
      t.string :logo
      t.string :game_version
      t.string :trdid, :unique => true
      t.datetime :start_at
      t.datetime :end_at
    end

    add_index(:hole_leagues, :trdid, unique: true, name: "idx_trdid_league")
  end
end
