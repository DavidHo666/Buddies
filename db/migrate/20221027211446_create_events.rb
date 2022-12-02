class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :event_name
      t.string :address
      t.datetime :start_time
      t.datetime :end_time
      t.float :price
      t.text :description
      t.string :tag
      t.integer :percentage
      t.string :pictures
      t.integer :available_spots
      t.integer :occupied_spots
      t.integer :organizer_id
      t.string :applicants_id
      t.timestamps
    end
  end
end
