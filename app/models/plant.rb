class Plant < ApplicationRecord
  belongs_to :kingdom
  belongs_to :division, :class_name => "Division", :foreign_key => "division_id", optional: true
  belongs_to :plant_class, :class_name => "PlantClass", :foreign_key => "plant_class_id", optional: true
  belongs_to :order, :class_name => "Order", :foreign_key => "order_id", optional: true
  belongs_to :family, :class_name => "Family", :foreign_key => "family_id", optional: true
  belongs_to :genus, :class_name => "Genu", :foreign_key => "genus_id"
  belongs_to :variety, :class_name => "Variety", :foreign_key => "variety_id", optional: true
  belongs_to :species
  
  def scientific_name
    return self.genus.name.titleize + " " + self.species.name.downcase
  end
end
