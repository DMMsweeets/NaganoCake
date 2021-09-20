# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Member.create(first_name: "yuu", last_name: "yama",
              first_name_kana: "yuu", last_name_kana: "yama",
              email: "yyuu@gmail.com",address: "123456", postal_code: "123456",
              phone_number: "123456", password: "123456")
              
Admin.create(email: "yuu@gmail.com", password: "123456")