class SunriseSunsetJob < ApplicationJob
	queue_as :default

	def perform(lat, long, date=Date.today.strftime("%Y-%m-%d"))

		if invalid_latitude(lat) 
			raise "Please pass me a valid latitude" 
		elsif invalid_longitude(long)
			raise "Please pass me a valid longitude"
		elsif invalid_date(date)
			raise "Please pass me a valid date. Date should be in format YYYY-MM-DD"
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

	def invalid_date(date)
		date.match(/^\d{4}\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01])$/).nil?
	end
end
