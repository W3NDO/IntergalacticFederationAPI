class FinancialTransaction < ApplicationRecord
    # before_validation :validate_planets

    belongs_to :pilot
    belongs_to :ship
    belongs_to :origin_planet, class_name: "Planet"
    belongs_to :destination_planet, class_name: "Planet", optional: true

    enum :transaction_type, {:resource_transport => 1, :fuel_refill => 2}

    private
    def validate_planets
        return true if self.origin_planet != self.destination_planet
        add_to_base("Origin Planet can not be the same as a destiantion planet.")
        prevent_save
    end
end
