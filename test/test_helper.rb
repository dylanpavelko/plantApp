ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def new_kingdom
    @kingdom = kingdoms(:one)
    @kingdom = Kingdom.new(name: @kingdom.name)
    @kingdom.save
    return @kingdom
  end

  def new_division
    @division = divisions(:one)
    @division = Division.new(name: @division.name, kingdom_id: new_kingdom.id)
    @division.save
    return @division
  end

  def new_plant_class
    @plant_class = plant_classes(:one)
    @plant_class = PlantClass.new(name: @plant_class.name, division_id: new_division.id)
    @plant_class.save
    return @plant_class
  end

  def new_order
    @order = orders(:one)
    @order = Order.new(name: @order.name, plant_class_id: new_plant_class.id)
    @order.save
    return @order
  end

  def new_family
    @family = families(:one)
    @family = Family.new(name: @family.name, order_id: new_order.id)
    @family.save
    return @family
  end

  def new_genus
    @genus = genus(:one)
    @genus = Genu.new(name: @genus.name, family_id: new_family.id)
    @genus.save
    return @genus
  end

  # Add more helper methods to be used by all tests here...
end
