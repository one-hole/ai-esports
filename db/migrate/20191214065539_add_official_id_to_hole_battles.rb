class AddOfficialIdToHoleBattles < ActiveRecord::Migration[6.0]
  def change
    add_column(:hole_battles, :official_id, :integer)
  end
end
