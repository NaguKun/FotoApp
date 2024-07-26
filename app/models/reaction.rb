class Reaction < ApplicationRecord
    belongs_to :user
    belongs_to :photo
  
    validates :user_id, uniqueness: { scope: :photo_id, message: "You've already liked this photo" }
end