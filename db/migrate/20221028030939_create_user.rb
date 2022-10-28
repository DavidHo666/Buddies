class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.text :bio
      t.datetime :joined_date
      t.timestamps
    end
  end
end
