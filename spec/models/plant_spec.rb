require 'rails_helper'

RSpec.describe Plant do
  describe 'relationships' do
    it { should have_many(:plot_plants) }
    it { should have_many(:plots).through(:plot_plants) }
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

  describe '#under_one_hundred' do
    it 'returns a true value if time to harvest is less than 100 days' do
      expect(@plant_1.under_one_hundred).to eq(true)
      expect(@plant_5.under_one_hundred).to eq(false)
    end
  end
end
