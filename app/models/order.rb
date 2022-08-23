class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  validates :name, :email, :phone, :zip_code, :state, :city, :address, :address_number, presence: true
end
