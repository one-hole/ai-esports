class Rename3rdToTrd < ActiveRecord::Migration[5.2]
  def change
    rename_column :hole_teams, "3rdid", :trdid
    rename_column :hole_battles, "3rdid", :trdid
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
