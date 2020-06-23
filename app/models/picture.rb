class Picture < ApplicationRecord

  belongs_to :product, optional: true

  validates :content, presence: true

  mount_uploader :picture, PictureUploader
end