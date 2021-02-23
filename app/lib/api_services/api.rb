require 'rest_client'
require 'json'

class APIServices::API

	def get_sunrise_and_sunset_times(params)
		begin
			response = RestClient.get('https://api.sunrise-sunset.org/json', params: params)
		rescue => e 
			e
		end
	end
end