class CreateCsgoMatchDetail < ActiveRecord::Migration[6.0]
  def change
    create_table :csgo_match_details do |t|
      t.bigint :match_id
      t.boolean :left_win_five,     comment: "先赢 5 回合"
      t.boolean :left_win_1,        comment: "首回合手枪局"
      t.boolean :left_win_16,       comment: "16回合手枪局"
      t.boolean :first_half_left_t, comment: "上半场左边是 T ？"
      t.integer :first_half_left_score
      t.integer :first_half_right_score
      t.integer :second_half_left_score
      t.integer :second_half_right_score
      t.string  :map
    end
  end
end
