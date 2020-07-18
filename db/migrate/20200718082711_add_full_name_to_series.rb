class AddFullNameToSeries < ActiveRecord::Migration[6.0]
  def change
    add_column(:embrace_series, :full_name, :string)
  end
end
