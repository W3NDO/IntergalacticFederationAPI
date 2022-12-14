class Resource < ApplicationRecord
    # because there are only 3 possible options for the resource name, easier to put them in an enum so that only these resources are valid.
    belongs_to :contract, optional: true
    
    enum :name, minerals: "minerals", water: "water", food: "food"
    validates :name, presence: true
    validates :weight, comparison: { greater_than: 0 }, presence: true
end
