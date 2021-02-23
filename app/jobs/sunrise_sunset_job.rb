class SunriseSunsetJob < ApplicationJob
	queue_as :default

	def perform(lat, long, date=Date.today)

		if invalid_latitude(lat) 
			raise "Please pass me a valid latitude" 
		elsif invalid_longitude(long)
			raise "Please pass me a valid longitude"
		end

		params = {'lat': lat, 'lng': long, 'date': date}
		response = ::APIServices::API.new.get_sunrise_and_sunset_times(params)
		parsed_response = JSON(response)

		puts "Sunrise is #{parsed_response["results"]["sunrise"]}"
		puts "Sunset is #{parsed_response["results"]["sunset"]}"
		
		if Search.find_by(latitude: lat, longitude: long, date: date)
			puts "Search not saved because it already exists in the database"
		else
			Search.create(latitude: lat, longitude: long, date: date)
			puts "Search saved in the database"
		end
	end

	def invalid_latitude(lat)
		lat < -90 || lat > 90
	end

	def invalid_longitude(long)
		long < -180 || long > 180
	end
end
