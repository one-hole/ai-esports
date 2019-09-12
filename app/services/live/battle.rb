module Live
  class Battle < Ohm::Model

    attribute :stream_delay_s
    attribute :steam_id
    attribute :left_score
    attribute :right_score
    attribute :lobby_id
    attribute :left_team_id
    attribute :right_team_id

    collection(:matches, 'Live::Match')
    reference(:left_team, 'Live::Team')
    reference(:right_taem, 'Live::Team')
  end
end