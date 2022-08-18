class BuyingGroup < ApplicationRecord
  validates :name, presence: true
  validates :date, presence: true

  has_many :batches

  enum status: { paused: 0, active: 1, finished: 2 }
end
