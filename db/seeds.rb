# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create({first_name: 'TimeMan', last_name: 'Admin', email: 'admin@example.com', password: 'timemanadmin', password_confirmation: 'timemanadmin', hours_per_day: 8, role: :admin})