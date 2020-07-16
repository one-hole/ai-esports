class CreateEmbraces < ActiveRecord::Migration[6.0]
  def change
    create_table :embrace_games do |t|
      t.string :name
      t.string :en_name
      t.string :abbr
      t.string :image
      t.string :latest_version
      t.timestamps
    end

    create_table :embrace_leagues do |t|
      t.bigint :third_id, comment: '三方的 ID，目前为 PandaScore'
      t.references :game
      t.string :name
      t.string :image
      t.timestamps
    end

    create_table :embrace_series do |t|
      t.bigint :third_id, comment: '三方的 ID，目前为 PandaScore'
      t.references :game
      t.references :league
      t.string :name
      t.string :cn_name
      t.datetime :begin_at
      t.datetime :end_at
      t.integer :year
      t.timestamps
    end

    create_table :embrace_tournaments do |t|
      t.bigint :third_id, comment: '三方的 ID，目前为 PandaScore'
      t.references :game
      t.references :league
      t.references :series
      t.string :name
      t.string :cn_name
      t.datetime :begin_at
      t.datetime :end_at
      t.timestamps
    end

    # 这里其实不需要存储大比分
    create_table :embrace_battles do |t|
      t.bigint :third_id, comment: '三方的 ID，目前为 PandaScore'
      t.references :game
      t.references :tournament
      t.timestamp :scheduled_at
      t.timestamp :begin_at
      t.timestamp :end_at
      t.integer :status
      t.boolean :has_websocket, default: false
      t.string :name
      t.references :left_team
      t.references :right_team
      t.timestamps
    end

    create_table :embrace_matches do |t|
      t.bigint :third_id, comment: '三方的 ID，目前为 PandaScore'
      t.references :battle
      t.integer :left_score
      t.integer :right_score
      t.integer :index
      t.integer :status
      t.bigint :winter_id
      t.timestamps
    end
  end
end
