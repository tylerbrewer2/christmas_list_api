# List
# - group_id
# - user_id
class List < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :items
end
