require 'rails_helper'

describe APIServices::API do

	describe '#get_sunrise_and_sunset_times' do

		let(:valid_params) { {'lat': '36.7201600', 'lng': '-4.4203400'} }
		let(:missing_longitude) { {'lat': '36.7201600'} }
		let(:missing_latitude) { {'lng': '-4.4203400'} }
		let(:valid_params_with_date) { {'lat': '36.7201600', 'lng': '-4.4203400', 'date': '2021-01-01'} }

		let(:invalid_date_params) { {'lat': '36.7201600', 'lng': '-4.4203400', 'date': 'Test1'} }
		let(:invalid_longitude) { {'lat': '36.7201600', 'lng': 'blahblahblah'} }
		let(:invalid_latitude) { {'lat': 'blobblobblob', 'lng': '-4.4203400'} }

		it "should fetch the sunrise and sunset times" do
			response = ::APIServices::API.new.get_sunrise_and_sunset_times(valid_params)
			expect(response.code).to eq(200)
		end

		it "should raise an error for missing required params" do
			response = ::APIServices::API.new.get_sunrise_and_sunset_times(missing_longitude)
			expect(response.http_code).to eq(400)

			response = ::APIServices::API.new.get_sunrise_and_sunset_times(missing_latitude)
			expect(response.http_code).to eq(400)			
		end

		it "should raise an error for invalid longitude and latitude" do
			response = ::APIServices::API.new.get_sunrise_and_sunset_times(invalid_longitude)
			expect(response.http_code).to eq(400)

			response = ::APIServices::API.new.get_sunrise_and_sunset_times(invalid_latitude)
			expect(response.http_code).to eq(400)
		end

		# I wanted to add cases for if the longitude or latitude is out of range 
		# (e.g. Latitude is greater than 90 or less than 0)
		# But the api interestingly does not return an error in that case.

		it "should fetch the sunrise and sunset times for a specific date" do
			response = ::APIServices::API.new.get_sunrise_and_sunset_times(valid_params_with_date)
			expect(response.code).to eq(200)
		end

		it "should raise an error for invalid date" do
			response = ::APIServices::API.new.get_sunrise_and_sunset_times(invalid_date_params)
			expect(response.http_code).to eq(400)
		end
	end
end