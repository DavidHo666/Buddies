class CreateParticipations < ActiveRecord::Migration[7.0]
  def change
    create_table :participations do |t|
      t.belongs_to :events
      t.belongs_to :users
      t.timestamps
    end
  end
end
