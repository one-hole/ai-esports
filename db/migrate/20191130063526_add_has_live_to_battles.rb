class AddHasLiveToBattles < ActiveRecord::Migration[6.0]
  def change
    add_column :hole_battles, :has_live, :boolean, default: false
  end
end
