require 'rails_helper'

RSpec.describe 'Plots Index Page' do
  before :each do
    @tcg = Garden.create!({name: 'Turing Community Garden', organic: true})
    @vegas = Garden.create!(name: 'Vegas Roots', organic: false)
    @dcg = Garden.create!(name: 'Denver Community Garden', organic: true)

    @plot_1 = Plot.create!({number: 12, size: "Medium", direction: "West", garden_id: @tcg.id})
    @plot_2 = Plot.create!({number: 1, size: 'Large', direction: 'East', garden_id: @tcg.id})
    @plot_3 = Plot.create!({number: 5, size: 'Small', direction: "North", garden_id: @vegas.id})
    @plot_4 = Plot.create!({number:2, size: 'Large', direction: 'South', garden_id: @dcg.id})

    @plant_1 = Plant.create!({name: 'Beefeater Tomato', description: 'Hearty in any soil, loves sun', time_to_harvest: 40})
    @plant_2 = Plant.create!({name: 'Big Basil', description: 'Needs rich soil', time_to_harvest: 10})
    @plant_3 = Plant.create!({name: "Sally's Serving Flowers", description: 'needs lots of water', time_to_harvest: 20})
    @plant_4 = Plant.create!({name: 'Bugs Carrots', description: 'Plant them and forget them', time_to_harvest: 18})

    @pp_1 = PlotPlant.create!({plot_id: @plot_1.id, plant_id: @plant_1.id})
    @pp_2 = PlotPlant.create!({plot_id: @plot_1.id, plant_id: @plant_2.id})
    @pp_3 = PlotPlant.create!({plot_id: @plot_1.id, plant_id: @plant_3.id})
    @pp_4 = PlotPlant.create!({plot_id: @plot_2.id, plant_id: @plant_3.id})
    @pp_5 = PlotPlant.create!({plot_id: @plot_3.id, plant_id: @plant_4.id})
  end

  it 'provides a list of each plot and their plants' do
    visit '/plots'

    expect(page).to have_content(@plot_1.number)
    expect(page).to have_content(@plot_2.number)
    expect(page).to have_content(@plot_3.number)
    expect(page).to have_content(@plot_4.number)
    expect(page).to have_content(@plant_1.name)
    expect(page).to have_content(@plant_3.name)
  end

  # User Story 2, Remove a Plant from a Plot
  # As a visitor
  # When I visit the plot's index page
  # Next to each plant's name
  # I see a link to remove that plant from that plot
  # When I click on that link
  # I'm returned to the plots index page
  # And I no longer see that plant listed under that plot
  # (Note: you should not destroy the plant record entirely)

  it 'can remove a plant from a plot' do
    visit '/plots'

    expect(page).to have_link("Remove #{@plant_1.name} from Plot")

    click_link "Remove #{@plant_1.name} from Plot"

    expect(page).to_not have_content(@plant_1.name)
    expect(current_path).to eq('/plots')
  end
end
