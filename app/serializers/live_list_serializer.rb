class LiveListSerializer < ScheduleSerializer
  attributes :left_score, :right_score, :match

  attributes :csgo_bps

  def csgo_bps
    return {} unless object.class.name == "CsgoSeries"
    return JSON.parse(CsgoBpSerializer.new(object.get_banpick).to_json)
  end

  def game_no
    object.left_score + object.right_score + 1
  end

  def csgo?
    object.is_a?(CsgoSeries)
  end

  def dota2?
    object.is_a?(Dota2Series)
  end

  def cur_match
    object.matches.find_by(game_no: game_no)
  end

  def match
    return nil unless cur_match
    if dota2?
      Dota2MatchSerializer.new(cur_match)
    elsif csgo?
      CsgoMatchSerializer.new(cur_match)
    end
  end

    class Dota2MatchSerializer < ActiveModel::Serializer
      attributes :left_team_kills, :right_team_kills, :left_team_towers, :right_team_towers
      attributes :left_team_ten_kills, :left_team_first_blood
      attributes :left_team_gold, :left_team_exp, :right_team_gold, :right_team_exp
      attributes :duration, :game_no, :id, :picks_bans, :left_radiant, :radiant_lead
      attributes :left_mega_creaps, :right_mega_creaps

      def left_team_towers
        get_tower_left(object.left_team_tower_state.to_i)
      end

      def right_team_towers
        get_tower_left(object.right_team_tower_state.to_i)
      end

      def get_tower_left(tower_state)
        count = 0
        while tower_state > 0
          count += 1 if (tower_state & 1) == 1
          tower_state >>= 1
        end
        count
      end

      def picks_bans
        return [] if object.picks_bans.nil?
        JSON.parse(object.picks_bans)
      end
    end

  class CsgoMatchSerializer < ActiveModel::Serializer
    attributes :id, :game_no, :map, :left_score, :right_score
    attributes :first_half_left_role, :first_half_pistol_left_win, :second_half_pistol_left_win

    attributes :first_half, :second_half
    attributes :left_win_five

    def left_win_five
      object.first_win_five
    end

    def score_log
      return [] if object.score_log.blank?
      @score_log ||= JSON.parse(object.score_log)
    end

    # ----------- score_info -------------------
    def score_info
      return @score_info unless @score_info.nil?
      return nil if object.score_info.blank?
      @score_info ||= JSON.parse(object.score_info)
    end

    def first_half
      return nil unless score_info_valid?
      return score_info["first_half"]
    end

    def second_half
      return nil unless score_info_valid?
      return score_info["second_half"]
    end

    def score_info_valid?
      return false if score_info.nil?
      true
    end

    def first_half_left_role
      return nil unless score_info_valid?
      score_info['firstLeft'] || score_info['first_left']
    end
  end

end
