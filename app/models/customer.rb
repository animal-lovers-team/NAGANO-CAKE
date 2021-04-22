class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :orders, dependent: :destroy

  #フルネームメソッド
  def full_name
    self.last_name + self.first_name
  end

  #フルネームカナメソッド
  def kana_full_name
    self.kana_last_name + self.kana_first_name
  end


  has_many :deliver_destinations, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :kana_first_name, presence: true
  validates :kana_last_name, presence: true
  validates :postal_code, presence: true, numericality: { only_integer: true }, length: { is: 7 }
  validates :street_address, presence: true
  validates :phone_number, presence: true, numericality: { only_integer: true }

end