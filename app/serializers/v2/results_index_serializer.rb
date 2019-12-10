module V2
  class ResultsIndexSerializer < ActiveModel::Serializer

    attributes :id, :game_no, :battle, :infos, :detail



    class TeamSerializer < ActiveModel::Serializer
      attributes :id, :name, :country, :logo
    end

    def live
      @live ||= JSON.parse(object.detail.live_detail)
    end

    def battle
      {
        id:           object.battle.id,
        status:       object.battle.status,
        format:       object.battle.format,
        left_score:   object.battle.left_score,
        right_score:  object.battle.right_score,
        left_team:    ActiveModelSerializers::SerializableResource.new(object.battle.left_team, {serializer: TeamSerializer}),
        right_team:   ActiveModelSerializers::SerializableResource.new(object.battle.right_team, {serializer: TeamSerializer})
      }
    end

    def infos
      {
        radiant_picks: eval(live["match"]["radiant_picks"]),
        radiant_bans:  eval(live["match"]["radiant_bans"]),
        dire_picks:    eval(live["match"]["dire_picks"]),
        dire_bans:     eval(live["match"]["dire_bans"]),
        max_gold_diff: live["match"]["diffs"].map { |d| d["gold_lead"].to_i }.max,
        min_gold_diff: live["match"]["diffs"].map { |d| d["gold_lead"].to_i }.min,
        max_exp_diff:  live["match"]["diffs"].map { |d| d["exp_lead"].to_i }.max,
        min_exp_diff:  live["match"]["diffs"].map { |d| d["exp_lead"].to_i }.min,
        diffs:         live["match"]["diffs"]
      }
    end

    def detail
      object.detail.info
    end
  end
end