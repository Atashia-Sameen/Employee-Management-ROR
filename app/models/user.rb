class User < ApplicationRecord
  belongs_to :organization
  has_many :leaves
  has_many :attendances
  has_many :work_from_homes
  has_one :own_organization, class_name: 'Organization', inverse_of: 'creator'

  enum role: { hr: 0, manager: 1, employee: 2 }
  
  validates :name, presence: true
  validates :role, presence: true
  validates :email, presence: true, format: { with: Devise.email_regexp }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :strip_value

  private

  def strip_value
    self.name = name.strip if self.name.present?
    self.email = email.strip if self.email.present?
  end
end
