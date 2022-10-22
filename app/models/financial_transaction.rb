class FinancialTransaction < ApplicationRecord
    before_save :set_ids

    belongs_to :pilot
    belongs_to :ship
    belongs_to :origin_planet, class_name: "Planet"
    belongs_to :destination_planet, class_name: "Planet"

    enum :transaction_type, {:resource_transport => 1, :fuel_refill => 2}

    private
    def set_ids
        self.pilot = Pilot.find_by(certification: self.certification)
        self.ship = Ship.find_by(name: self.ship_name)
        self.origin_planet = Planet.find_by(name: self.transaction_origin_planet)
        self.destination_planet = Planet.find_by(name: self.transaction_destination_planet)
    end
end
