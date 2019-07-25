class Division < ApplicationRecord
    belongs_to :kingdom, :class_name => "Kingdom", :foreign_key => "kingdom_id"
    
    def names
        return self.name + " (" + self.common_name + ")"
    end
end
