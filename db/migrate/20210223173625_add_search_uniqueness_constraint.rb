class AddSearchUniquenessConstraint < ActiveRecord::Migration[5.2]
  def change
  	add_index :searches, [:latitude, :longitude, :date], unique: true
  end
end
