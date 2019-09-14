module Live
  module Util
    module Validator
      def valid_battle?(game)
        return false if (game['radiant_team'].nil? || game['dire_team'].nil?) # => 天辉夜魇队伍名称及ID
        return false if game['scoreboard'].nil?                               # => 计分板信息
        return false if game['scoreboard']['radiant'].nil?                    # => 天辉数据
        return false if game['scoreboard']['dire'].nil?                       # => 夜魇数据
        return false if game['scoreboard']['radiant']['picks'].nil?           # => 天辉pick
        return false if game['scoreboard']['dire']['picks'].nil?              # => 夜魇pick
        return false if game['scoreboard']['radiant']['bans'].nil?            # => 天辉ban
        return false if game['scoreboard']['dire']['bans'].nil?               # => 夜魇ban
        return true
      end
    end
  end
end