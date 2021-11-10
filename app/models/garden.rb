class Garden < ApplicationRecord
  has_many :plots

  def all_mature_plants
    Plant.joins(:plots).where("days_to_harvest < 100")
  end
end
