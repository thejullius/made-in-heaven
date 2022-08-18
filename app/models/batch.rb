class Batch < ApplicationRecord
  validates :description, :amount, :quantity, presence: true
  validates :amount, :quantity, numericality: true
  belongs_to :buying_group
end
