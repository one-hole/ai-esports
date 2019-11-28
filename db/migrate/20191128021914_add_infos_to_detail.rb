class AddInfosToDetail < ActiveRecord::Migration[6.0]
  def change
    add_column :match_details, :radiant_lead, :integer, default: 0
    add_column :match_details, :radiant_exp_lead, :integer, default: 0
    add_column :match_details, :radiant_first_blood, :boolean
    add_column :match_details, :radiant_first_tower, :boolean
    add_column :match_details, :radiant_ten_kills, :boolean
  end
end
