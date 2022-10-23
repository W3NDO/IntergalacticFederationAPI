class Planet < ApplicationRecord
    has_many :financial_transactions

    validates :resources_received, presence: true
    validates :resources_sent, presence: true

    TRAVEL_ADJACENCY_LIST = {
        # Origin_planet => {
            # destination_planet => amount of fuel
        # }
        "andvari" => {
            "aqua" => 13,
            "calas" => 23,
            "demeter" => -1 # if amount of fuel is -1, then travel is blocked
        },
        "demeter" => {
            "aqua" => 22,
            "calas" => 25,
            "andvari" => -1
        },
        "aqua" => {
            "demeter" => 30,
            "calas" => 12,
            "andvari" => -1
        },
        "calas" => {
            "andvari" => 20,
            "demeter" => 25,
            "aqua" => 15
        }
    }
    def self.travellable?(origin, destination, fuel)
        return false if TRAVEL_ADJACENCY_LIST[origin.downcase][destination.downcase] == -1
        return true if TRAVEL_ADJACENCY_LIST[origin.downcase].keys.include?(destination.downcase) and TRAVEL_ADJACENCY_LIST[origin.downcase][destination.downcase] < fuel
        false
    end

    def self.travellable_with_fuel?(origin, destination, fuel)
        return [false, "route_block"] if TRAVEL_ADJACENCY_LIST[origin.downcase][destination.downcase] == -1
        return [false, "fuel"] if TRAVEL_ADJACENCY_LIST[origin.downcase].keys.include?(destination.downcase) and TRAVEL_ADJACENCY_LIST[origin.downcase][destination.downcase] > fuel
        return [true, nil]
    end

    def update_totals
        # sent = self.
    end
end
