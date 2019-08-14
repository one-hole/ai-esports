class CreateServers < ActiveRecord::Migration[5.2]
  def change
    # create_table :servers do |t|
    #   t.belongs_to :tenant
    #   t.string     :host
    #   t.string     :tag
    # end

    # add_index(:servers, [:host, :tenant_id], name: "idx_host_server")
  end
end
