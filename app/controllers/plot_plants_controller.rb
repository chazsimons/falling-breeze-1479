class PlotPlantsController < ApplicationController

  def destroy
    plot = Plot.find(params[:plot_id])
    plant = Plant.find(params[:plant_id])
    PlotPlant.where(plot_id: plot.id, plant_id: plant.id).destroy_all
    redirect_to '/plots'
  end
end
