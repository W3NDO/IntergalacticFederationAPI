class FinancialTransaction < ApplicationRecord
    # before_validation :validate_planets
    # after_create :backfill_fields

    belongs_to :pilot
    belongs_to :ship
    belongs_to :origin_planet, class_name: "Planet"
    belongs_to :destination_planet, class_name: "Planet", optional: true
    has_one :contract

    enum :transaction_type, :resource_transport => "resource_transport", :fuel_refill => "fuel_refill", default: :resource_transport

    validates :description, presence: true
    validates :amount, presence: true
    validates :pilot_id, presence: true
    validates :origin_planet_id, presence: true
    validates :ship_id, presence: true

    private
    #v2 methods
    def validate_planets
        return true if self.origin_planet != self.destination_planet
        add_to_base("Origin Planet can not be the same as a destiantion planet.")
        prevent_save
    end

    def backfill_fields
        temp = self
        temp.ship_name = Ship.find(self.ship_id).name
        temp.pilot_certification = Pilot.find(self.pilot_id).certification
        temp.transaction_origin_planet = Planet.find(self.origin_planet_id).name
        if temp.destination_planet_id
            temp.transaction_destination_planet = Planet.find(self.destination_planet_id).name
        end
        temp.save if temp.valid?
    end
end
