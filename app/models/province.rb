class Province < ApplicationRecord
  has_many :customers

  validates :name, presence: true
  validates :GST, numericality: { greater_than_or_equal_to: 0.0 }, allow_nil: true
  validates :PST, numericality: { greater_than_or_equal_to: 0.0 }, allow_nil: true
  validates :HST, numericality: { greater_than_or_equal_to: 0.0 }, allow_nil: true
end
