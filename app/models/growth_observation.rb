require 'open-uri'


class GrowthObservation < ApplicationRecord
  belongs_to :plant_instance
  belongs_to :bbch_stage
  has_one_attached :picture do |attachable|
    attachable.variant :thumb, resize: "100x100"
  end
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"

  validates :observation_date, :presence => true
  validate :image_type

  def grab_image(uri)
    puts Dir.pwd
    puts uri
    #downloaded_image = File.open(uri)
    file_contents = URI.open(uri) { |f| f.read }
    @uri_name_parts = uri.split('/')
    @filename = @uri_name_parts[@uri_name_parts.size - 1]
    self.picture.attach(io: downloaded_image  , filename: @filename)
  end

  private

  def image_type
    if picture.attached? && !picture.content_type.in?(%w(image/png image/jpeg)) #Mime::Types
      picture.purge
      errors.add(:picture, 'Must be a PNG or JPG')
    end
  end

end
