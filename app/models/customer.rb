class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders

  belongs_to :province, optional: true

  validates :first_name, allow_nil: true, format: { with: /[\w\-\s]/ }
  validates :last_name, allow_nil: true, format: { with: /[\w\-\s]/ }
  validates :apartment, allow_blank: true, format: { with: /[\w-]/ }
  validates :street_number, allow_nil: true, format: { with: /[\w-]/ }
  validates :street_name, allow_nil: true, format: { with: /[a-zA-Z0-9\s-]/ }
  validates :city, allow_nil: true, format: { with: /[\w\-\s]/ }
  validates :postal_code, allow_nil: true,
                          format:    { with: /\A([ABCEGHJKLMNPRSTVXY][0-9][ABCEGHJKLMNPRSTVWXYZ])\ ?([0-9][ABCEGHJKLMNPRSTVWXYZ][0-9])\z/ }
  validates :phone, allow_nil: true,
                    format:    { with: /\A(1?)(-| ?)(\()?([0-9]{3})(\)|-| |\)-|\) )?([0-9]{3})(-| )?([0-9]{4}|[0-9]{4})\z/ }
  validates :email, allow_nil: true, format: { with:
                                                     /\A([a-zA-Z0-9_\-.]+)@([a-zA-Z0-9_\-.]+)\.([a-zA-Z]{2,5})\z/ }
  validates :province_id, allow_blank: true, numericality: { only_integer: true }
end
