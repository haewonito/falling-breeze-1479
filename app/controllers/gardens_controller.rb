class GardensController < ApplicationController

  def show
    @garden = Garden.find(params[:garden_id])

    @plants = @garden.all_mature_plants.distinct
  end
end
