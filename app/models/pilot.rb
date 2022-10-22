class Pilot < ApplicationRecord
    has_one :ship
    has_many :financial_transactions

    
    validates :certification, presence: true, uniqueness: true
    validates :name, presence: true
    validates :age, comparison: { greater_than: 18 }       
end
