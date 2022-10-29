json.extract! event, :id, :event_name, :address, :start_time, :end_time, :price, :description, :tag, :pictures, :available_spots, :occupied_spots, :organizer_id, :applicants_id, :created_at, :updated_at
json.url event_url(event, format: :json)
