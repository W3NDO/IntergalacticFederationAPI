class Contract < ApplicationRecord
    
    # before_save :check_validity

    enum :status, {:open => 0, :closed => 1}

    validates :description, presence: true
    validates :payload, presence: true, inclusion: {in: %w(minerals water food), message: "%{value} is not a valid payload"}
    validates :origin_planet, presence: true, inclusion: {in: Planet::TRAVEL_ADJACENCY_LIST.keys, message: "%{value} is not a valid planet"}
    validates :destination_planet, presence: true, inclusion: {in: Planet::TRAVEL_ADJACENCY_LIST.keys, message: "%{value} is not a valid planet"}
    validates :value_cents, presence: true
    validates :status, presence: true

    private
    def check_validity
        errors.add_to_base("Can not travel to #{self.destination_planet}") and return false unless Planet::TRAVEL_ADJACENCY_LIST.keys.include?(self.origin_planet.downcase)
        errors.add_to_base("Can not travel from #{self.origin_planet} to #{self.destination_planet}") and return unless Planet::TRAVEL_ADJACENCY_LIST[self.origin_planet].keys.include?(self.destination_planet.downcase)
        return
    end
end
