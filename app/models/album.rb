class Album < ApplicationRecord
  belongs_to :user

  enum sharing_mode: [ :public_mode, :private_mode ]
  has_many_attached :album_images
end