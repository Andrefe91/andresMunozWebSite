class CreateVisits < ActiveRecord::Migration[8.0]
  def change
    create_table :visits do |t|
      t.inet :ip
      t.string :destination

      t.timestamps
    end
  end
end
