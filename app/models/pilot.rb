class Pilot < ApplicationRecord
    has_one :ship
    
    validates :certification, presence: true, uniqueness: true
    validates :name, presence: true
    validates :age, comparison: { greater_than: 18 }       
end
