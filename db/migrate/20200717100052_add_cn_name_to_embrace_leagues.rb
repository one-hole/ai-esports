class AddCnNameToEmbraceLeagues < ActiveRecord::Migration[6.0]
  def change
    add_column(:embrace_leagues, :cn_name, :string)
  end
end
