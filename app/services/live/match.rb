# 最后的实时信息应该从这里出
# 这里每次完成 Persist 之后需要清除自己的信息
# 这里需要真实的关注 天辉 和 夜魇

module Live
  class Match < Ohm::Model

    attribute :game_no
    attribute :status
    attribute :battle_id
    attribute :reverse
    attribute :duration
    attribute :roshan_respawn_timer

    index :battle_id
    index :game_no

    reference(:battle, 'Live::Battle')
    collection(:players, 'Live::Player')

    # 这里持久化到数据库里面
    def persist
    end
  end
end