# Battle 只有系列赛的信息
# Match  只有当前正在打的信息

module Ohms
  class Battle < Ohm::Model

    attribute :steam_id           # 对应的就是 Steam APi 里面的 MatchID
    attribute :left_team_id,  ->(x) { x.to_i }      # 初始化的时候为 radiant (存储的是 Ohm 里面的 TeamID)
    attribute :right_team_id, ->(x) { x.to_i }      # 初始化的时候为 dire
    attribute :left_score         # 大比分
    attribute :right_score        # 大比分
    attribute :server_steam_id    # Steam 服务器的 ID
    attribute :format
    attribute :created_at
    attribute :updated_at
    attribute :match_id

    unique :steam_id

    reference(:match, "Ohms::Match")
    reference(:left_team, "Ohms::Team")
    reference(:right_team, "Ohms::Team")
  end
end
