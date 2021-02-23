class Search < ApplicationRecord
	validates :latitude, presence: true
	validates :longitude, presence: true
	attribute :date, presence: true
end
