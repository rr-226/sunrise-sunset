class SearchController < ApplicationController

	def create
		@search = Search.new(search_params)


		if @search.save
			puts "Search was saved successfully"
		else
			raise "Search was not saved"
		end
	end

	def new
		@search = Search.new
	end


	private

	def search_params
		params.require(:latitude, :longitude, :date).permit(:formatted)
	end
end
