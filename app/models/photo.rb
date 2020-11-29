class Photo < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  validates :title, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader
end
