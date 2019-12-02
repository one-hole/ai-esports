module Ohms
  class Diff < Ohm::Model

    attribute :match_id
    attribute :duration
    attribute :gold_lead
    attribute :exp_lead

  end
end

# 所以这里每次 Push 的时候需要比对 Duration 的大小
# 经济差就是 net_worth 的差
# 经验差就是 