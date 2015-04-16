# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Rails.env.development?
  User.find_or_create_by(email: 'Owner@MSDS.com') do |user|
    user.password = 'password123'
  end

  company = Company.new(
  name: Faker::Company.name,
  user_id: 1
  )
  company.save!
end
