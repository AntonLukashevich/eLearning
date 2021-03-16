FactoryBot.define do
  factory :testing do
    title {"Test testing"}
    description {"Testing description"}
    association :course, factory: :course
  end
end