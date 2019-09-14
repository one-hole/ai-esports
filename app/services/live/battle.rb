module Live
  class Battle < Ohm::Model

    attribute :stream_delay_s
    attribute :steam_id
    attribute :radiant_score
    attribute :dire_score
    attribute :lobby_id
    attribute :radiant_team_id
    attribute :dire_team_id

    unique :steam_id #唯一性索引、可以使用 with 方法查询

    collection(:matches, 'Live::Match')
    collection(:players, 'Live::Player')

    reference(:radiant_team, 'Live::Team')
    reference(:dire_taem, 'Live::Team')
  end
end

# Slot 0 是 radiant