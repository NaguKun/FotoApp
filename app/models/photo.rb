class Photo < ApplicationRecord
  belongs_to :user

  enum sharing_mode: { public_mode: 0, private_mode: 1 }
  has_one_attached :photo_image
  has_many :reactions, dependent: :destroy

  scope :public_albums, -> { where(sharing_mode: :public_mode) }

  def self.search(query)
    where("title LIKE ? OR description LIKE ?", "%#{query}%", "%#{query}%")
  end
end
