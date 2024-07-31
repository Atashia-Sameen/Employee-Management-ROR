class Organization < ApplicationRecord
  has_many :users
  validates :name, presence: true
  validates :creator_id, presence: true

  
end
