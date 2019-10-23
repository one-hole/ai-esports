module Live
  module Tops
    module Util
      module Validator
        def valid_battle?(battle)
          return false if (battle["team_id_radiant"].nil? || battle["team_id_dire"].nil?)
          return true
        end
      end
    end
  end
end

# team_id_radiant
# team_id_dire
# team_name_radiant
# team_name_dire
