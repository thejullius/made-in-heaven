class BuyingGroup < ApplicationRecord
  validates :name, :date, presence: true

  has_many :batches

  enum status: { inactive: 0, active: 1, finished: 2 }
end
