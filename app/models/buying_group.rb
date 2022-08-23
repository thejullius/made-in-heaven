class BuyingGroup < ApplicationRecord
  validates :name, :date, :status, presence: true

  has_many :batches
  has_many :orders

  enum status: { inactive: 0, active: 1, finished: 2 }
end
