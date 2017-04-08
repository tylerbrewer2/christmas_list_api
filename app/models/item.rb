# Item
# - name*
# - url*
# - price
# - list_id
class Item < ApplicationRecord
  belongs_to :list
  validates :name, :url, presence: true
  validates :url, format: { with: URI.regexp }
end
