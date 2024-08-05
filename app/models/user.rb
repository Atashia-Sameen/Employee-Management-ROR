class User < ApplicationRecord
  belongs_to :organization
  has_many :leaves
  has_many :attendances
  has_many :work_from_homes

  enum role: { hr: 0, manager: 1, employee: 2 }
  
  validates :name, presence: true
  validates :role, presence: true
  validates :email, presence: true, format: { with: Devise.email_regexp }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
