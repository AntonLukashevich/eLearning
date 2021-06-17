# frozen_string_literal: true

FactoryBot.define do
  factory :readed do
    association :lecture, factory: :lecture
    association :user, factory: :user
    is_readed { true }
  end
end
