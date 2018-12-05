class CreateLolConstantSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :lol_skills do |t|

      t.integer :hero_id
      t.string  :en_name
      t.string  :cn_name
      t.text    :desc, comment: '技能描述'
      t.string  :short, limit: 4, comment: '快捷键'
    end

    add_index(:lol_skills, [:hero_id, :short], unique: true, name: 'short_on_skills')
  end
end
