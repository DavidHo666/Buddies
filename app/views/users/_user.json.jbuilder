json.extract! user, :id, :username, :email, :password, :bio, :joined_date, :created_at, :updated_at
json.url user_url(user, format: :json)
