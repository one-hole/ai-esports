class CreateHoleBattle < ActiveRecord::Migration[5.2]
  def change
    create_table :hole_battles do |t|
      t.boolean :manual, comment: "如果是手动、那么 Spider 就不在处理这个数据"
      t.integer :left_team_id
      t.integer :right_team_id
      t.integer :format
      t.string  :type
      t.integer :status, default: 1
      t.timestamp
    end
  end
end
