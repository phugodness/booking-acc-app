class Amentity < ApplicationRecord
  DEFAULT_PARAMS = [:internet, :air_conditioning, :cable_tv, :breakfast, :parking, :elevator, :heating, :hot_tub].freeze
  belongs_to :room
end
