class AddInfoToCsgoMatchDetails < ActiveRecord::Migration[6.0]
  def change
    add_column(:csgo_match_details, :info, :text)
  end
end
