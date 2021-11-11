class Garden < ApplicationRecord
  has_many :plots
  has_many :plot_plants
  has_many :plants, through: :plot_plants

  def get_plants
    unique_plants = plots.map do |plot|
                      plot.plants.map do |plant|
                        plant.name if plant.under_one_hundred
                      end.compact
                    end.flatten!.uniq!
    unique_plants
  end

  # def unique_plants
  #   require "pry"; binding.pry
  #   plots
  # end
end
