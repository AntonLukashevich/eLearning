# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    answer    { 'Test answer' }
    isCorrect { [true, false].sample }
    position  { rand 1..7 }
    association :question, factory: :question
  end
end
