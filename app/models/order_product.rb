class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :price_per_item, numericality: { greater_than: 0.0 }
  validates :subtotal, numericality: { greater_than: 0.0 }
  validates :GST, numericality: { greater_than_or_equal_to: 0.0 }, allow_nil: true
  validates :PST, numericality: { greater_than_or_equal_to: 0.0 }, allow_nil: true
  validates :HST, numericality: { greater_than_or_equal_to: 0.0 }, allow_nil: true
end
