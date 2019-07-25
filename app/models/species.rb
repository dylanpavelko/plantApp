class Species < ApplicationRecord
    belongs_to :genus, :class_name => "Genu", :foreign_key => "genus_id"
end
