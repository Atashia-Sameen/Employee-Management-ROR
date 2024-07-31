class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  belongs_to :organization
  has_many :leaves
  has_many :attendances
  has_many :work_from_homes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { hr: 0, manager: 1, employee: 2 }

  validates :name, presence: true
  validates :role, presence: true
  validates :email, presence: true
end
