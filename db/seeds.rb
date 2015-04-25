# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# if Rails.env.development?
  User.find_or_create_by(email: 'thomas@owner.com') do |user|
    user.password = 'password123'
    user.role = 'owner'
  end

  User.find_or_create_by(email: 'thomas@admin.com') do |user|
    user.password = 'password123'
    user.role = 'admin'
  end

  User.find_or_create_by(email: 'thomas@user.com') do |user|
    user.password = 'password123'
  end

  5.times do
    admin = User.new(
      email: Faker::Internet.email,
      password: Faker::Internet.password,
      role: 'admin'
    )
    admin.save
    company = Company.new(
      name: Faker::Company.name,
      user_id: admin.id
    )
    company.save
    CompanyUser.create(company_id: company.id, user_id: admin.id)
  end

  10.times do
    user = User.new(
      email: Faker::Internet.email,
      password: Faker::Internet.password
    )
    user.save
    CompanyUser.create(company_id: rand(1..Company.count), user_id: user.id)
  end

  15.times do
    data_sheet = DataSheet.new(
      number: Faker::Number.number(10),
      name: Faker::Commerce.product_name,
      sds: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'OSHA3514.pdf')),
      company_id: rand(1..Company.count)
    )
    data_sheet.save
  end
# end
