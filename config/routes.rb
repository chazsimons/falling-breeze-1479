Rails.application.routes.draw do

  get '/plots', to: 'plots#index'

  delete '/plots/:plot_id/plants/:plant_id', to: 'plot_plants#destroy'
end
