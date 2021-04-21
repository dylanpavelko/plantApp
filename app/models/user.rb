class User < ApplicationRecord
    has_secure_password
    belongs_to :high_level_location, :class_name => "HighLevelLocation", :foreign_key => "high_level_location_id", :optional => true

    
    validates :email, presence: true, uniqueness: true
end
