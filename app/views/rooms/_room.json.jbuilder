json.extract! room, :id, :type_of_room_id, :user_id, :name, :address, :number_of_guest, :price, :accomodates, :number_of_bed, :description, :house_rules, :longitude, :latitude, :created_at, :updated_at
json.url room_url(room, format: :json)
