class Patient < ApplicationRecord
    validates :name, :age, :disease, :address, :registered_on, presence: true
    validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
