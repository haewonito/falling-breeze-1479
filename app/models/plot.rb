class Plot < ApplicationRecord
  belongs_to :garden
  has_many :plot_plants
  has_many :plants, through: :plot_plants


  def list_plant_names
    plants.pluck(:name)
  end
end
