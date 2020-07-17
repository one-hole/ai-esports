class CreateEmbraceTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :embrace_teams do |t|
      t.bigint :third_id, comment: '三方的 ID，目前为 PandaScore'
      t.references :game
      t.string :official_id
      t.string :image
      t.string :country
      t.string :name
      t.string :abbr
      t.string :snd_name
    end
  end
end
