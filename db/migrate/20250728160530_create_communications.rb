class CreateCommunications < ActiveRecord::Migration[8.0]
  def change
    create_table :communications do |t|
      t.string :email
      t.text :message, limit: 1000

      t.timestamps
    end
  end
end
