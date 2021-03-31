# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    title { 'Test course' }
    description { 'Test description' }
    status { 'Test status' }
    type_course { 'Test type' }
    rating { '55' }
  end
end
