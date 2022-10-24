class Pilot < ApplicationRecord
    has_one :ship
    has_many :financial_transactions

    
    validates :certification, presence: true, uniqueness: true
    validates :name, presence: true
    validates :age, comparison: { greater_than: 17 }     

    def update_totals(resources)
        valid_keys = ["minerals", "water", "food"]
        temp_exclusions = []
        resources.keys.each do |key|
            temp_exclusions << key unless valid_keys.include?(key)
        end
        resources = resources.except(temp_exclusions.join(','))
        old_values = self.totals
        resources.each do |k,v|
            old_values[k] = old_values[k] + resources[k]
        end
        self.update(totals: old_values) and return true
        return false
    end
end
