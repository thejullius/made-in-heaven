class Batch < ApplicationRecord
  validates :description, :amount, :quantity, :width,
            :height, :length, :weight, presence: true

  validates :amount, :quantity, :width, :height,
            :length, :weight, numericality: true

  belongs_to :buying_group
end
