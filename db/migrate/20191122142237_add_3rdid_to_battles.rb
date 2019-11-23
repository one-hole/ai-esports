class Add3rdidToBattles < ActiveRecord::Migration[5.2]
  def change
    add_column :hole_battles, "3rdid", :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")

    add_index :hole_battles, "3rdid", name: "idx_3rd_on_battles"
    add_index :hole_battles, :status, name: "idx_status_on_battles"

  end
end
