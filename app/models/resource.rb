class Resource < ApplicationRecord
  belongs_to :species, :optional => true
  belongs_to :plant, :optional => true
end
