class BbchProfile < ApplicationRecord
	has_many :stages, :through => :bbch_stages
end
