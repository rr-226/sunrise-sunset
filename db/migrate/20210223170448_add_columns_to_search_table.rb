class AddColumnsToSearchTable < ActiveRecord::Migration[5.2]
  def change
  	add_column :searches, :latitude, :decimal
  	add_column :searches, :longitude, :decimal
  	add_column :searches, :date, :date
  	add_column :searches, :formatted, :boolean
  end
end
