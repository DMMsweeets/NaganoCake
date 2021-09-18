class Delivery < ApplicationRecord
  validates :name, presence: true, length: { maximum: 25 }
  validates :address, presence: true
  validates :postal_code, presence: true
end
