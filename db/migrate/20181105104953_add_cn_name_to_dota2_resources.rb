class AddCnNameToDota2Resources < ActiveRecord::Migration[5.2]
  def change
    add_column :dota2_heroes,    :cn_name, :string
    add_column :dota2_items,     :cn_name, :string
    add_column :dota2_abilities, :cn_name, :string

    add_column :dota2_heroes, :dac, :string
    add_column :dota2_heroes, :droles, :string

    add_column :dota2_abilities, :desc, :text
  end
end
