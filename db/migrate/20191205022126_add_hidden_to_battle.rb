class AddHiddenToBattle < ActiveRecord::Migration[6.0]
  def change
    add_column :hole_battles, :hidden, :boolean, default: false
  end
end
