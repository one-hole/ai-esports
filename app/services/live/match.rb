module Live
  class Match < Ohm::Model
    attribute :game_no
    attribute :status
    attribute :battle_id

    index :battle_id

    reference(:battle, 'Live::Battle')
    # 这里持久化到数据库里面
    def persist
    end
  end
end