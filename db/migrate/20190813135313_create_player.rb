class CreatePlayer < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|

      t.string :personaname
      t.string :officalname
      t.bigint :account_id,  comment: "Steam ID -> account_id"
      t.string :avatar

    end
  end
end
