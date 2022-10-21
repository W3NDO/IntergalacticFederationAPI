class Contract < ApplicationRecord
    validates :description, presence: true
    validates :payload, presence: true, inclusion: {in: %w(minerals water food), message: "%{value} is not a valid payload"}
    validates :origin_planet, presence: true
    validates :destination_planet, presence: true
    validates :value, presence: true
end
