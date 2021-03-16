FactoryBot.define do
  factory :user do
    first_name {Faker::Name.first_name}
    last_name  {Faker::Name.last_name}
    email      {Faker::Internet.email}
    password   {"123123"}
    avatar     {Faker::Avatar.image}
    association :role, factory: :role
    # Add additional fields as required via your User model
  end
end