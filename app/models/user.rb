class User < ApplicationRecord
  has_many :lists
  has_many :items, through: :lists
  has_many :groups, through: :lists

  validates :first_name, :email, presence: true
end
