class AddColumnToEmbraceLeagues < ActiveRecord::Migration[6.0]
  def change
    add_column(:embrace_leagues, :abbr, :string)
  end
end
