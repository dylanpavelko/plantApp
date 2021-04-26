class Species < ApplicationRecord
    belongs_to :genus, :class_name => "Genu", :foreign_key => "genus_id"
    belongs_to :bbch_profile, :class_name => "BbchProfile", :foreign_key => "bbch_profile_id", :optional => true

    def full_species_name
    	return genus.name + " " + self.name
    end
end
