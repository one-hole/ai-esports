class ResultListSerializer < ScheduleSerializer

  attributes :left_score, :right_score, :matches
  def game_no
    if object.status == 'ongoing'
      object.left_score + object.right_score + 1
    else
      object.left_score + object.right_score
    end
  end

  # ----- 队伍信息 ------------------
  belongs_to :left_team
  belongs_to :right_team

  class TeamSerializer < ActiveModel::Serializer
    attributes :id, :logo, :tag, :extern_id
  end

  # ------ Dota 2比赛信息 ------------------
  class Dota2MatchSerializer < ActiveModel::Serializer
    attributes :left_team_win
    attributes :left_team_kills, :right_team_kills
    attributes :left_team_ten_kills, :left_team_first_blood
    attributes :duration, :game_no, :picks_bans
    
    def picks_bans
      begin
        JSON.parse(object.picks_bans)
      rescue
        nil
      end
    end
  end

  # ------ Csgo比赛信息 -------------
  class CsgoMatchSerializer < ActiveModel::Serializer
    attributes :id, :game_no, :map, :left_score, :right_score
    attributes :first_half_pistol_left_win, :second_half_pistol_left_win

    def score_log
      return [] if object.score_log.blank?
      @score_log ||= JSON.parse(object.score_log)
    end
  end

  # ------ Lol比赛信息 -------------
  class LolMatchSerializer < ActiveModel::Serializer
    attributes :id, :game_no, :left_team_five_kills, :left_team_first_blood
    attributes :left_team_kills, :right_team_kills, :left_team_win
  end

  # ------ Kog比赛信息 -------------
  class KogMatchSerializer < ActiveModel::Serializer
    attributes :id, :game_no, :left_team_ten_kills, :left_team_first_blood
    attributes :left_team_first_tower, :left_team_win
  end

  def ongoing_or_finished_matches
    object.matches.where('game_no <= ?', game_no)
  end

  def matches
    res = []
    ongoing_or_finished_matches.each do |match|
      if dota2?
        res << Dota2MatchSerializer.new(match)
      elsif csgo?
        res << CsgoMatchSerializer.new(match)
      elsif lol?
        res << LolMatchSerializer.new(match)
      elsif kog?
        res << KogMatchSerializer.new(match)
      end
    end
    res
  end

  def csgo?
    object.is_a?(CsgoSeries)
  end

  def dota2?
    object.is_a?(Dota2Series)
  end

  def lol?
    object.is_a?(LolSeries)
  end

  def kog?
    object.is_a?(KogSeries)
  end
end