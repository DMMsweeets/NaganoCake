class Item < ApplicationRecord
 attachment :image
 belongs_to :genre
 has_many :cart_items
 has_many :order_details

 validates :name, presence: true
 validates :body, presence: true
 validates :price, presence: true
end
