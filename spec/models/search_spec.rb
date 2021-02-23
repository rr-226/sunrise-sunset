require 'rails_helper'

RSpec.describe Search, type: :model do
  describe "#validations" do

  	subject do 
  		described_class.new(
  			latitude: 36.7201600,
  			longitude: -4.4203400,
  			date: "2020-12-12"
  		)
  	end

  	it "is valid with valid attributes" do 
  		expect(subject).to be_valid
  	end

  	context "when a required attribute is missing" do
  	  	subject do 
	  		described_class.new(
	  			latitude: 36.7201600,
	  			date: "2020-12-12"
	  		)
	  	end

	  	it "is invalid with invalid attributes" do
	  		expect(subject).to_not be_valid
	  	end
  	end	
  end
end
