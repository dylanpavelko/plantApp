class Genu < ApplicationRecord
    belongs_to :family, :class_name => "Family", :foreign_key => "family_id"
end
