class RenameColumnMatchDetail < ActiveRecord::Migration[6.0]
  def change
    rename_column :match_details, :radiant_lead,        :left_lead
    rename_column :match_details, :radiant_exp_lead,    :left_exp_lead
    rename_column :match_details, :radiant_first_blood, :left_first_blood
    rename_column :match_details, :radiant_first_tower, :left_first_tower
    rename_column :match_details, :radiant_ten_kills,   :left_ten_kills
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
