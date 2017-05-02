# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# TypeOfRoom.create(name: 'Home/Flat')
# TypeOfRoom.create(name: 'Hotel')
# TypeOfRoom.create(name: 'Shared Room')
# Status.create(code: '001', name: 'Waiting')
# Status.create(code: '002', name: 'Confirmed')
# Status.create(code: '003', name: 'Cancelled')
# UserType.create(code: 01, )
# a = Room.create!(type_of_room_id: 1, user_id: 2, name: 'Golden Plaza', address: 'K34/3/3 Au Co, Lien Chieu District, Danang City, Vietnam', number_of_guest: 2, accomodates: 2, number_of_bed: 2, description: 'A new place', house_rules: 'No Smoking, No pets', price: 25, number_of_room: 1)
# b = Room.create!(type_of_room_id: 2, user_id: 3, name: 'My Nest Home', address: '22 Ngo Thi Nham, Lien Chieu District, Danang City, Vietnam', number_of_guest: 4, accomodates: 4, number_of_bed: 2, description: 'A Nes home for backpacker', house_rules: 'No Smoking, No pets', price: 30, number_of_room: 3)
# c = Room.create!(type_of_room_id: 3, user_id: 5, name: 'Summer Paradise', address: '102 Nguyen Van Linh, Hai Chau District, Danang City, Vietnam', number_of_guest: 6, accomodates: 5, number_of_bed: 3, description: 'Come and enjoy your summer at here', house_rules: 'Feel Free to do anything you want', price:50, number_of_room: 1)
Amentity.create(room_id: 52 ,internet: true, air_conditioning: true, cable_tv: true, breakfast: true, parking: false, elevator: true, heating: true, hot_tub: false)
Amentity.create(room_id: 53 ,internet: false, air_conditioning: true, cable_tv: true, breakfast: false, parking: false, elevator: false, heating: true, hot_tub: false)
Amentity.create(room_id: 54 ,internet: true, air_conditioning: false, cable_tv: true, breakfast: true, parking: false, elevator: false, heating: true, hot_tub: false)
Review.create(room_id: 52, user_id: 2, rank: 5, comment: 'very nice')
# Reservation.create(user_id: 2, checkin_date: Date.new(2017, 1, 2), checkout_date: Date.new(2017, 1, 10), number_of_guest: 3, service_fee: 5)
