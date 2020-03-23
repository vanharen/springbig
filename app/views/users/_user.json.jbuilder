json.extract! user, :id, :first, :last, :phone, :email, :created_at, :updated_at
json.url user_url(user, format: :json)
