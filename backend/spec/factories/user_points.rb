FactoryBot.define do
  factory :user_point do
    association :user
    points { 0 }
  end
end 