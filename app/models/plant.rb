class Plant < ApplicationRecord
  has_many :plot_plants
  has_many :plots, through: :plot_plants


  def under_one_hundred
    time_to_harvest < 100
  end
end
