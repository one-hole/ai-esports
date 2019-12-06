class AddFiveKillsToDetail < ActiveRecord::Migration[6.0]
  def change
    add_column :match_details, :left_five_kills, :boolean
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
