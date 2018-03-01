# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do

  User.destroy_all
  a = User.new(email: 'A')
  b = User.new(email: 'B')
  c = User.new(email: 'C')
  a.save!
  b.save!
  c.save!

  ShortenedUrl.destroy_all
  one = ShortenedUrl.create!(long_url: 'long', user: a)
  two = ShortenedUrl.create!(long_url: 'long2', user: a)
  three = ShortenedUrl.create!(long_url: 'long3', user: b)
  four = ShortenedUrl.create!(long_url: 'long3', user: c)
  five = ShortenedUrl.create!(long_url: 'long2', user: a)

  Visit.destroy_all
  v1 = Visit.record_visit!(a, four)
  v2 = Visit.record_visit!(c, five)
  v3 = Visit.record_visit!(b, four)
  v4 = Visit.record_visit!(c, one)
  v5 = Visit.record_visit!(c, one)
  v6 = Visit.record_visit!(c, one)


end
