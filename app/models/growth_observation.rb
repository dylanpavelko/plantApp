class GrowthObservation < ApplicationRecord
  belongs_to :plant_instance
  belongs_to :bbch_stage
  has_one_attached :picture do |attachable|
    attachable.variant :thumb, resize: "100x100"
  end

  validates :observation_date, :presence => true
  validate :image_type

  private

  def image_type
    if picture.attached? && !picture.content_type.in?(%w(image/png image/jpeg)) #Mime::Types
      picture.purge
      errors.add(:picture, 'Must be a PNG or JPG')
    end
  end

end
