class Organization < ApplicationRecord
  has_many :users
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  validates :name, presence: true
  validates :creator_id, presence: true
end
