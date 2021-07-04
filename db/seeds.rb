# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


5.times do |number|
  User.create(name: "test@test#{number + 1}", email: "test@test#{number + 1}", password: "test@test#{number + 1}")
end

User.all.each do |user|
  3.times do |number|
    user.books.create(title: "test@test#{user.id}_#{number + 1}", body: "test@test#{user.id}_#{number + 1}")
  end
end