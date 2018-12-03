class CreateLolConstantHeros < ActiveRecord::Migration[5.2]
  def change
    create_table :lol_heroes do |t|
      t.string  :cn_name
      t.string  :en_name
      t.string  :nick
      t.integer :offical_id
      t.integer :attack
      t.integer :defense
      t.integer :magic
      t.integer :difficulty
    end
  end
end
