class AddUserIdToEvents < ActiveRecord::Migration[7.0]
  def change
    # add_column :events, :user_id, :integer
    # add_index :events, :user_id
    add_reference :events, :users, foreign_key: true
  end
end
