class Dota2Match < ApplicationRecord
  include ArcWardenDbConcern
  self.table_name = "dota2_matches"

  belongs_to :match_series
  belongs_to :left_team, foreign_key: 'left_team_id', class_name: 'Team'
  belongs_to :right_team, foreign_key: 'right_team_id', class_name: 'Team'

  def left_radiant
    radiant_team_id == left_team.extern_id
  end

  def left_mega_creaps
    return 0 if barracks_status_radiant.nil? || barracks_status_dire.nil?
    b_barracks_status = left_radiant ? barracks_status_radiant.to_s(2) : barracks_status_dire.to_s(2)
    creaps = 0
    0.upto(2).each do |i|
      creaps += 1 if b_barracks_status[i * 2, 2] == '00' 
    end
    creaps
  end

  def right_mega_creaps
    return 0 if barracks_status_radiant.nil? || barracks_status_dire.nil?
    b_barracks_status = left_radiant ? barracks_status_dire.to_s(2) : barracks_status_radiant.to_s(2)
    creaps = 0
    0.upto(2).each do |i|
      creaps += 1 if b_barracks_status[i * 2, 2] == '00'
    end
    creaps
  end
end