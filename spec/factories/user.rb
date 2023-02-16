FactoryBot.define do
  factory :user do
    username { "test" }
    sequence :email do |n|
      "test#{n}@example.com"
    end
    password { "password" }
    password_confirmation { "password" }
    profile_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_user.png')) }
  end
end
