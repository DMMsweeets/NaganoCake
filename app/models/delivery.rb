class Delivery < ApplicationRecord
  validates :name, presence: true, length: { maximum: 25 }
  validates :address, presence: true
  validates :postal_code, presence: true

  belongs_to :member

  def full_deliveries
    "#{self.postal_code} #{self.address} #{self.name}"
  end
end
