class Picture < ApplicationRecord
  mount_uploader :content, PictureUploader
  belongs_to :product, optional: true
end
