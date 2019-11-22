class CreateHoleTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :hole_teams do |t|
      t.string :type
      t.string :name
      t.string :abbr
      t.string :logo
      t.string :country
      t.string :official_id
    end
  end
end
