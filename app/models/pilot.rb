class Pilot < ApplicationRecord
    has_one :ship, dependent: :destroy
    
    validates :certification, presence: true, uniqueness: true, if: :certificate_valid?
    validates :name, presence: true
    validates :age, comparison: { greater_than: 18 }       

    def certificate_valid?
        # validates that the certification is legitimate using Luhn Validation
        digits = certification.digits
        digits.each_with_index do |num, index|
            if index.odd?
                temp = digits[6-index]*2
                while temp > 9 do
                    temp = temp.digits.sum
                end
                digits[6-index] = temp
            end
        end
        digits.sum % 10 == 0
    end
end
