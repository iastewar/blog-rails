# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u  = User.create({first_name: "A", last_name: "B", email: "email@email.com", password: "a"})

100.times do

  Post.create({title: Faker::Company.bs,
                   body:  Faker::Lorem.paragraph, user_id: u.id })
end

tags = ["science", "programming", "cats", "pyjamas", "gems"]

tags.each do |tag|
  Tag.create(name: tag)
end
