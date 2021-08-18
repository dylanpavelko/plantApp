class Resource < ApplicationRecord
  belongs_to :species, :optional => true
  belongs_to :plant, :optional => true
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
end
