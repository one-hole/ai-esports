class AddSndNameToTeam < ActiveRecord::Migration[6.0]
  def change
    add_column :hole_teams, :snd_name, :string
  end
end
