class Contract < ApplicationRecord
    
    # before_save :check_validity

    belongs_to :financial_transaction, optional: true
    has_many :resources
    accepts_nested_attributes_for :resources, reject_if: ->(attributes){ attributes['name'].blank? }, allow_destroy: true

    enum :status, open: "open", closed: "closed", active: "active", default: :closed

    validates :description, presence: true
    validates :payload, presence: true, inclusion: {in: %w(minerals water food), message: "%{value} is not a valid payload"}
    validates :origin_planet, presence: true, inclusion: {in: Planet::TRAVEL_ADJACENCY_LIST.keys, message: "%{value} is not a valid planet"}
    validates :destination_planet, presence: true, inclusion: {in: Planet::TRAVEL_ADJACENCY_LIST.keys, message: "%{value} is not a valid planet"}
    validates :value_cents, presence: true
    validates :status, presence: true

    def combine_resources_to_hash
        resources = self.resources
        hash = {}
        resources.each do |resource|
            hash[resource.name] = hash.fetch(resource.name, 0) + resource.weight
        end
        hash
    end
    private
    def check_validity
        errors.add_to_base("Can not travel to #{self.destination_planet}") and return false unless Planet::TRAVEL_ADJACENCY_LIST.keys.include?(self.origin_planet.downcase)
        errors.add_to_base("Can not travel from #{self.origin_planet} to #{self.destination_planet}") and return unless Planet::TRAVEL_ADJACENCY_LIST[self.origin_planet].keys.include?(self.destination_planet.downcase)
        return
    end
end
