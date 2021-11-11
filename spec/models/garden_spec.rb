require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
  end

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
    @plant_5 = Plant.create!({name: 'Super Acai Berry', description: 'Worth the wait', time_to_harvest: 101})

    @pp_1 = PlotPlant.create!({plot_id: @plot_1.id, plant_id: @plant_1.id})
    @pp_2 = PlotPlant.create!({plot_id: @plot_1.id, plant_id: @plant_2.id})
    @pp_3 = PlotPlant.create!({plot_id: @plot_1.id, plant_id: @plant_3.id})
    @pp_4 = PlotPlant.create!({plot_id: @plot_2.id, plant_id: @plant_3.id})
    @pp_5 = PlotPlant.create!({plot_id: @plot_3.id, plant_id: @plant_4.id})
    @pp_6 = PlotPlant.create!({plot_id: @plot_1.id, plant_id: @plant_5.id})
  end

  describe '#get_plants' do
    it 'returns a list of a gardens unique plants which take under 100 days to harvest' do
      results = @tcg.get_plants

      expect(results).to eq([@plant_1.name, @plant_2.name, @plant_3.name])
    end
  end
end
