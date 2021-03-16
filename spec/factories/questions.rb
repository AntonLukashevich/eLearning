FactoryBot.define do
  factory :question do
    question {"test Question"}
    type {"radio"}
    association :testing, factory: :testing
  end
end