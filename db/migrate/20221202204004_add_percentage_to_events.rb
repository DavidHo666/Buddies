class AddPercentageToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :percentage, :integer
  end
end
