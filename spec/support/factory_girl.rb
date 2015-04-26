require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :company do
    sequence(:name) { |n| "#{n} Inc." }
  end

  factory :data_sheet do
    number '357325853483'
    name 'Poison'
    sds { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'OSHA3514.pdf')) }
  end
end
