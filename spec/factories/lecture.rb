# frozen_string_literal: true

FactoryBot.define do
  factory :lecture do
    title { Faker::Lorem.words(number: 3) }
    description { Faker::Lorem.words(number: 30) }
    content { Faker::Lorem.words(number: 30) }
    association :course, factory: :course
  end
end
