class Plant < ApplicationRecord
  #belongs_to :kingdom
  # belongs_to :division, :class_name => "Division", :foreign_key => "division_id", optional: true
  # belongs_to :plant_class, :class_name => "PlantClass", :foreign_key => "plant_class_id", optional: true
  # belongs_to :order, :class_name => "Order", :foreign_key => "order_id", optional: true
  #belongs_to :family, :class_name => "Family", :foreign_key => "family_id", optional: true
  #belongs_to :genus, :class_name => "Genu", :foreign_key => "genus_id"
  belongs_to :variety, :class_name => "Variety", :foreign_key => "variety_id", optional: true
  belongs_to :cultivator, :class_name => "Cultivator", :foreign_key => "cultivator_id", optional: true
  belongs_to :species
  has_many :common_names, :class_name => "CommonName", :foreign_key => "plant_id"
  
  def scientific_name
    sci_name = "<em>" + self.genus.name.titleize + " " + self.species.name.downcase + "</em>"
    if self.variety != nil 
      sci_name = sci_name + " var. " + "<em>" + self.variety.name.downcase + "</em>"
    end
    if self.cultivator != nil
      sci_name = sci_name + " '" + self.cultivator.name + "'"
    end
    return sci_name.html_safe
  end
  
  def scientific_name_with_common_names
    full_name = self.scientific_name
    if self.common_names.count > 0
      full_name = full_name + " - " + self.common_names_list
    end
    return full_name
  end
  
  def common_names_list
    names = ""
    self.common_names.each do |cn|
      names = names + cn.name + ", "
    end
    return names.delete_suffix(", ")
  end

  def genus
    return self.species.genus
  end
  
  def family
    return self.genus.family
  end
  
  def order
    return self.family.order
  end
  
  def plant_class
    return self.order.plant_class
  end
  
  def division
    return self.plant_class.division
  end
  
  def kingdom
    return self.division.kingdom
  end

end
