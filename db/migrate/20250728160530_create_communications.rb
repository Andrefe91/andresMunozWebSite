class CreateCommunications < ActiveRecord::Migration[8.0]
  def change
    create_table :communications do |t|
      t.string :email
      t.string :message, limit: 500

      t.timestamps
    end
  end
end
