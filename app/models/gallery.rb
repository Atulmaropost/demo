class Gallery < ApplicationRecord
	 validates_uniqueness_of :name, :case_sensitive => false
	mount_uploader :gallery_image, GalleryUploader
	belongs_to :user
end
