class Add3rdIdToHoleTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :hole_teams, "3rdid", :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    add_index :hole_teams, "3rdid", name: "idx_3rd_in_ht"
  end
end
