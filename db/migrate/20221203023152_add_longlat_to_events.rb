class AddLonglatToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :longitude, :float
    add_column :events, :latitude, :float
  end
end
