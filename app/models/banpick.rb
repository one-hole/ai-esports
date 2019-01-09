class Banpick < ActiveRecord::Base
  include ArcWardenDbConcern
  self.table_name = "banpicks"
  belongs_to :bpable, :polymorphic => true

  delegate :left_team, to: :bpable
  delegate :right_team, to: :bpable
  
end
