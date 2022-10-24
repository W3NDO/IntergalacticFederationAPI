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

    def update_totals(new_sent, new_received)
        valid_keys = ["minerals", "water", "food"]
        temp_exclusions = []
        (new_sent.merge new_received).keys.each do |key|
            temp_exclusions << key unless valid_keys.include?(key)
        end
        new_sent = new_sent.except(temp_exclusions.join(','))
        new_received = new_received.except(temp_exclusions.join(','))
        old_sent = self.resources_sent
        new_sent.each do |k, v|
            old_sent[k] = old_sent[k] + new_sent[k] if valid_keys.include?(k.downcase)
        end

        old_received = self.resources_received
        new_received.each do |k, v|
            old_received[k] = old_received[k] + new_received[k] if valid_keys.include?(k.downcase)
        end
        self.update(resources_sent: old_sent, resources_received: old_received) and return true
        false
    end

end
