class BbchStage < ApplicationRecord
  belongs_to :bbch_profile

  def principal_stage
  	if self.code < 10
  		return "Germination"
  	elsif self.code < 20
  		return "Leaf Development"
  	elsif self.code < 30
  		return "Tillering/Formation of Side Shoots"
  	elsif self.code < 40
  		return "Stem Elongation"
  	elsif self.code < 50
  		return "Development of Stolons and Young Plants/Harvestable Vegtative Plant Parts/Booting"
  	elsif self.code < 60
  		return "Inflorescence Emergence"
  	elsif self.code < 70
  		return "Flowering, anthesis"
  	elsif self.code < 80
  		return "Development of Fruit"
  	elsif self.code < 90
  		return "Ripening of fruit and seed"
  	elsif self.code < 100
  		return "Senescence/Beginning of Dormancy"
  	else
  		return "Growth"
  	end
  end

  def stage_name
    return self.principal_stage + " > " + self.description + " (" + self.code.to_s + ")"
  end
end
