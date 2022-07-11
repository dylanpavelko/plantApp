class Season < ApplicationRecord

  attr_accessor :year

  def initialize(year)
    @year = year
  end

  def persisted?
    false
  end

  def days_until_early_plant_development
    days_until_early_plant_development
  end

  def days_until_main_plant_development
    days_until_main_plant_development
  end

  def days_until_flowering
    days_until_flowering
  end

  def days_until_fruit_development
    days_until_fruit_development
  end

  def days_until_fruit_maturity
    days_until_fruit_maturity
  end

  def days_until_dormancy
    days_until_dormancy
  end

  def observations
    observations
  end

end