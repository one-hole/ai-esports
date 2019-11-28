class MatchDetail < ApplicationRecord
  belongs_to :match, class_name: "Hole::Match"


  def info
    begin
      @result = JSON.parse(detail)["result"]

      {
        duration:       @result["duration"],
        start_time:     Time.at(@result["start_time"]),
        radiant_score:  @result["radiant_score"],
        dire_score:     @result["dire_score"],
        radiant_team: radiant_info,
        dire_team:    dire_info
      }
    rescue => e
      {
        message: "暂无数据"
      }
    end
  end

  def radiant_info
    {
      tower_status:     @result["tower_status_radiant"],
      barracks_status:  @result["barracks_status_radiant"],
      players:        @result["players"].select { |item| item["player_slot"] < 10 }
    }
  end

  def dire_info
    {
      tower_status:       @result["tower_status_dire"],
      barracks_status:    @result["barracks_status_dire"],
      players: @result["players"].select { |item| item["player_slot"] > 100 }
    }
  end
end

# Slot 0 是 Radiant