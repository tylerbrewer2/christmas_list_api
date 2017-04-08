# Group
# - name*
class Group < ApplicationRecord
  has_many :lists
  has_many :users, through: :lists
  has_many :items, through: :lists

  validates :name, presence: true
end
