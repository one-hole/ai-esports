class AddLeftRadiantToDota2Detail < ActiveRecord::Migration[6.0]
  def change
    add_column(:match_details, :left_radiant, :boolean)
  end
end
