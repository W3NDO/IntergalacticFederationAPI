class Pilot < ApplicationRecord
    has_one :ship, dependent: :destroy
    
    validates :certification, presence: true, uniqueness: true, if: :certificate_valid?
    validates :name, presence: true
    validates :age, comparison: { greater_than: 18 }       
end
