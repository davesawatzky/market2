class Product < ApplicationRecord
  has_many :order_products
  has_many :orders, through: :order_products

  belongs_to :category

  has_one_attached :image

  validates :name, presence: true
  validates :brand, presence: true
  validates :inventory, presence:     true,
                        numericality: { only_integer: true, greater_than_or_equal_to: 0.0 }
  validates :floor_date, presence: true
  validates :SKU, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
end
