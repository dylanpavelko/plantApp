class Division < ApplicationRecord
    belongs_to :kingdom, :class_name => "Kingdom", :foreign_key => "kingdom_id"

    validates :kingdom, :presence => true
    
    def names
        return self.name + " (" + self.common_name + ")"
    end
end
