module Live
  class Battle < Ohm::Model

    attribute :steam_id

    collection(:matches, 'Live::Match')
  end
end