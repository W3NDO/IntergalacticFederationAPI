class Resource < ApplicationRecord
    # because there are only 3 possible options for the resource name, easier to put them in an enum so that only these resources are valid.
    enum :name, {:minerals => 1, :water => 2, :food => 3}
    validates :name, presence: true
    validates :weight, comparison: { greater_than: 0 }, presence: true
end
