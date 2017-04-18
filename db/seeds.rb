# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cat.destroy_all

c1 = Cat.create(birth_date: '11-11-2016', color: 'white', name: 'Monte', sex: 'M')
c2 = Cat.create(birth_date: '02-03-1989', color: 'black', name: 'Victor', sex: 'M')
c3 = Cat.create(birth_date: '03-06-2000', color: 'blue', name: 'Jin', sex: 'F')

CatRentalRequest.destroy_all

CatRentalRequest.create(cat_id: c1.id, start_date: '01-01-2016', end_date: '01-02-2016', status: 'APPROVED')
CatRentalRequest.create(cat_id: c2.id, start_date: '01-01-2017', end_date: '01-02-2017', status: 'PENDING')
CatRentalRequest.create(cat_id: c3.id, start_date: '01-01-2015', end_date: '01-02-2015', status: 'DENIED')
