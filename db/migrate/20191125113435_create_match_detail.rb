class CreateMatchDetail < ActiveRecord::Migration[6.0]
  def change
    create_table :match_details do |t|
      t.references :match
      t.text       :detail
    end
  end
end
