class AddLocationToVisits < ActiveRecord::Migration[8.0]
  def change
    add_column :visits, :location, :string, limit: 25
  end
end
