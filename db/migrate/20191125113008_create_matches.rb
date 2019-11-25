class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :hole_matches do |t|
      t.string      :type
      t.references  :battle
      t.string      :official_id
      t.integer     :game_no
      t.timestamps
    end
  end
end
