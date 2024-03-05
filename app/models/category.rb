class Category < ApplicationRecord
  has_many :products

  validates :name, presence: true, format: { with: /[a-zA-Z0-9]/ }
end
