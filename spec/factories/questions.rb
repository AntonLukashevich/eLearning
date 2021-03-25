FactoryBot.define do
  factory :question do
    question {"test Question"}
    type_question {"radio"}
    association :testing, factory: :testing
  end
end