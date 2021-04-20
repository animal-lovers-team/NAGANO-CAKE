class Product < ApplicationRecord

  belongs_to :genre

  has_many :order_datails, dependent: :destroy

  has_many :cart_items, dependent: :destroy

  attachment :image
	has_many :orders, through: :order_details
	has_many :order_details
	validates :genre_id, :name, :tax_out_price, presence: true
	validates :explanation, length: {maximum: 200}
	validates :tax_out_price, numericality: { only_integer: true }
end
