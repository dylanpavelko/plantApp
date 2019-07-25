class Kingdom < ApplicationRecord
    
    def names
        return self.name + " (" + self.common_name + ")"
    end
end
