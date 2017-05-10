class Status < ApplicationRecord
  has_many :reservations, dependent: :destroy
end
