# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# require "csv"
#
# CSV.foreach('db/user.csv') do |row|
#   User.create(id:       row[0],
#               name:     row[1],
#               email:    row[2],
#               profile:  row[3],
#               password: row[4],
#               created_at: Time.now,
#               updated_at: Time.now
#
#   )
# end

# fakerを利用したユーザデータ
100.times do |n|
  n += 1

  name     = Faker::Name.name
  email    = SecureRandom.uuid + "@railstutorial.org"
  password = "password123456"
  user = User.create!(uid: "#{n}",
               name: name,
               email: email,
               password:              password,
               password_confirmation: password)

  title_base   = "題名#{n}"
  content_base = "#{name}です。\rよろしくお願いします"
  Blog.create!(title:  title_base,
               content: content_base,
               user_id: user.id)
end
