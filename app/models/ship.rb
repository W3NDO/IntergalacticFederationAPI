class Ship < ApplicationRecord
    belongs_to :pilot, class_name: "Pilot", foreign_key: "pilots_id"

    validates :fuel_capacity, presence: true
    validates :weight_capacity, presence: true
end
