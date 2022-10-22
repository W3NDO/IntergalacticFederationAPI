class Ship < ApplicationRecord
    belongs_to :pilot
    has_many :financial_transactions

    validates :fuel_level, presence: true, comparison: { greater_than: 0}
    validates :fuel_capacity, presence: true, comparison: { greater_than: 0}
    validates :weight_capacity, presence: true
end
