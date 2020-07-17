class CreateEmbracePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :embrace_players do |t|
      t.bigint :third_id, comment: '三方的 ID，目前为 PandaScore'
      t.references :game
      t.references :team
      t.string :name
      t.string :role
      t.string :country
    end
  end
end
