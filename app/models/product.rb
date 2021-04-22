class Product < ApplicationRecord

  belongs_to :genre

  has_many :order_datails, dependent: :destroy

  has_many :cart_items, dependent: :destroy

  attachment :image


end
