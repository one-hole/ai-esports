# MatchSeries & 找到当前正在打的 Match

class LiveSerializer < ActiveModel::Serializer
  attributes :id, :cur_match

  def cur_match
    return nil unless currenct_match
  end

  class Dota2MatchLiveSerializer < ActiveModel::Serializer
  end

  class CsgoMatchLiveSerializer < ActiveModel::Serializer
  end

  private
    def game_no
      object.left_score + object.right_score + 1
    end

    def currenct_match
      object.matches.find_by(game_no: game_no)
    end

end
