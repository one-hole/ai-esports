class CreateDota2Constant < ActiveRecord::Migration[5.2]

  def self.up
    create_table :dota2_abilities, force: true do |t|
      t.integer :steam_id, null: false
      t.string  :en_name,  null: false
      t.string  :lg_avatar, default: ''
      t.string  :md_avatar, default: ''
      t.string  :sm_avatar, default: ''
    end

    create_table :dota2_heroes, force: true do |t|
      t.integer :steam_id, null: false, comment: '这个 WebAPi 请求的时候返回的英雄 ID、同时也是 YML 里面的 ID'
      t.string  :en_name,  null: false, comment: '英雄的官方名字'
      t.string  :full_avatar, default: '', comment: '英雄full图'
      t.string  :lg_avatar, default: '', comment: '英雄lg图'
      t.string  :sm_avatar, default: '', comment: '英雄eg图'
      t.string  :vert_avatar, default: '', comment: '英雄vert图'
    end

    create_table :dota2_items, force: true do |t|
      t.integer :steam_id,  null: false, comment: '物品的 SteamID'
      t.string  :en_name,   null: false
      t.string  :lg_avatar, default: '', comment: '物品eg图'
      t.string  :eg_avatar, default: '', comment: '物品lg图'
    end

    add_index(:dota2_abilities, :steam_id, name: 'index_steam_on_abilities')
    add_index(:dota2_heroes, :steam_id, name: 'index_steam_on_heroes')
    add_index(:dota2_items, :steam_id, name: 'index_steam_on_items')
  end

  def self.down
    drop_table :dota2_abilities
    drop_table :dota2_heroes
    drop_table :dota2_items
  end
end
