class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products

  belongs_to :customer

  validates :date_submitted, presence: true
  validates :date_delivered, presence: true, allow_nil: true
  validates :subtotal, numericality: { greater_than_or_equal_to: 0.0 }, allow_nil: true
  validates :shipping_cost, numericality: { greater_than_or_equal_to: 0.0 }, allow_nil: true
  validates :totalPST, numericality: { greater_than_or_equal_to: 0.0 }, allow_nil: true
  validates :totalGST, numericality: { greater_than_or_equal_to: 0.0 }, allow_nil: true
  validates :totalHST, numericality: { greater_than_or_equal_to: 0.0 }, allow_nil: true
  validates :total_cost, numericality: { greater_than: 0.0 }
  validates :transaction_number, presence: true, format: { with: /[0-9]/ }
end
