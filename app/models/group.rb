# Group
# - name*
class Group < ApplicationRecord
  has_many :lists
  has_many :users, through: :lists

  validates :name, presence: true
end
