class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_item
  has_many :order_detail
  
  attachment :image
  validates :name, {presence: true}
  validates :introduction, {presence: true}
  validates :price, {presence: true}
end
