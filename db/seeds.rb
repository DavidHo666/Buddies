# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


events = [{:event_name => 'swimming', :tag => 'Athletics', :address => 'Central Park',
           :price => 20, :start_time => '25-Nov-2022', :end_time => '25-Nov-2022',
           :available_spots => 10, :occupied_spots => 5},
          {:event_name => 'Concert', :tag => 'Music', :address => 'Central Park',
           :price => 20, :start_time => '25-Nov-2022', :end_time => '25-Nov-2022',
           :available_spots => 10, :occupied_spots => 5}
]

events.each do |event|
  Event.create(event)
end