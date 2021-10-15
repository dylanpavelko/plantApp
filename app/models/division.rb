class Division < ApplicationRecord
    belongs_to :kingdom, :class_name => "Kingdom", :foreign_key => "kingdom_id"
    belongs_to :bbch_profile, :class_name => "BbchProfile", :foreign_key => "bbch_profile_id", :optional => true

    validates :kingdom, :presence => true
    
    def names
        return self.name + " (" + self.common_name + ")"
    end
end
