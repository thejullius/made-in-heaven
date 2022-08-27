class Order < ApplicationRecord
  has_one_attached :document

  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  validates :name, :email, :phone, :zip_code, :state, :shipment_service,
            :city, :address, :address_number, :document, presence: true

  enum status: { awaiting_review: 0, reviewed: 1, denied: 2, posted: 3 }
  enum shipment_service: { correios_pac: 1, correios_sedex: 2, jadlog_economic: 3, jadlog_express: 4 }

  def items_sum
    order_items.map { |order_item| order_item.quantity * order_item.batch.amount }.sum
  end

  def items_and_shipment_sum
    items_sum + shipment_cost
  end
end
