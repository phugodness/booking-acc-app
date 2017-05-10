class TypeOfRoom < ApplicationRecord
  has_many :rooms, dependent: :destroy
end
