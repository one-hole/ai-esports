module Live
  class Team < Ohm::Model
    attribute :name
    attribute :logo
    attribute :steam_id
    attribute :battle_id

    unique :steam_id #唯一性索引、可以使用 with 方法查询
    index :name

    collection(:players, 'Live::Player')
    reference(:battle, 'Live::Battle')
  end
end