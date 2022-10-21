class Contract < ApplicationRecord
    validates :description, presence: true
    validates :payload, presence: true, inclusion: {in: %w(minerals water food), message: "%{value} is not a valid payload"}
    validates :origin_planet, presence: true, inclusion: {in: Planet::TRAVEL_ADJACENCY_LIST.keys.map{|k| k.titleize }, message: "%{value} is not a valid planet"}
    validates :destination_planet, presence: true, inclusion: {in: Planet::TRAVEL_ADJACENCY_LIST.keys.map{|k| k.titleize }, message: "%{value} is not a valid planet"}
    validates :value, presence: true
end
