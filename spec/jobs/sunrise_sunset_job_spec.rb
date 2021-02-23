require 'rails_helper'

RSpec.describe SunriseSunsetJob, type: :job do

	describe "#perform" do

		let(:latitude) { 36.7201600}
		let(:longitude) { -4.4203400 }
		let(:date) { Date.today.strftime("%Y-%m-%d") }

		context "when the search is unique" do
			it "should increase the search count" do
				expect { described_class.new.perform(latitude, longitude) }.to change { Search.count }
			end
		end

		context "when the search is not unique" do
			before do
				Search.create(latitude: latitude, longitude: longitude, date: date)
			end

			it "should not increase the search count" do
				expect{ described_class.new.perform(latitude, longitude) }.to_not change { Search.count }
			end
		end
	end

	describe "#invalid_latitude" do
		it "identifies > 90 as invalid" do
			latitude = rand(91..200)
			expect(described_class.new.invalid_latitude(latitude)).to be_truthy
		end

		it "identifies < -90 as invalid" do
			latitude = rand(-200..-91)
			expect(described_class.new.invalid_latitude(latitude)).to be_truthy
		end

		it "identifies range -90 through 90 as valid" do
			latitude = rand(-90..90)
			expect(described_class.new.invalid_latitude(latitude)).to be_falsey
		end
	end

	describe "#invalid_longitude" do
		it "identifies > 180 as invalid" do
			longitude = rand(181..300)
			expect(described_class.new.invalid_longitude(longitude)).to be_truthy
		end

		it "identifies < -180 as invalid" do
			longitude = rand(-300..-181)
			expect(described_class.new.invalid_longitude(longitude)).to be_truthy
		end

		it "identifies range -90 through 90 as valid" do
			longitude = rand(-180..180)
			expect(described_class.new.invalid_longitude(longitude)).to be_falsey
		end
	end

	describe "#invalid_date" do
		it "identifies YYYY-MM-DD as a valid date" do
			date = "2020-01-01"
			expect(described_class.new.invalid_date(date)).to be_falsey
		end

		it "identifies DD-MM-YYYY as an invalid date" do
			date = "02-02-2021"
			expect(described_class.new.invalid_date(date)).to be_truthy
		end
 	end
end
