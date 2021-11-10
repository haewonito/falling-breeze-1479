class PlotPlantsController < ApplicationController

  def destroy
    plot = Plot.find(params[:plot_id_to_delete])
    plant = Plant.find(name: params[:plant_name_to_delete])
    plot_plant = PlotPlant.find(plot_id: plot.id, plant_id: plant.id)

    plot_plant.destroy

    redirect_to "/plots"
  end

end
