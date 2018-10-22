class CreateTenants < ActiveRecord::Migration[5.2]
  def change
    create_table :tenants do |t|

      t.datetime :expire_time,  default: Time.at(0), comment: 'APi 过期时间'
      t.text     :public_key,       comment: '我们签发的公钥'
      t.text     :private_key,      comment: '我们签发的私钥'
      t.string   :api_key,          default: ''
      t.string   :api_path,         comment: '推送的 APi 路径'
    end

    add_index(:tenants, :api_key, name: 'key_on_tenants')
  end
end
