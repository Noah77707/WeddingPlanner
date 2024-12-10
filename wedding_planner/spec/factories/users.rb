FactoryBot.define do
  factory :user do
    name { "John Doe" }
    last_name { "Doe" }
    email { "user@example.com" }
    password { "password123" }
    password_confirmation { "password123" }
  end
end
