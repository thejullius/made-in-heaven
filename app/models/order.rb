class Order < ApplicationRecord
  has_one_attached :document

  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  validates :name, :email, :phone, :zip_code, :state, :shipment_service,
            :city, :address, :address_number, :document, presence: true

  enum status: { awaiting_review: 0, reviewed: 1, denied: 2, posted: 3 }
end
