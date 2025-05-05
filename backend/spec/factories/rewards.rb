FactoryBot.define do
  factory :reward do
    sequence(:title) { |n| "Reward #{n}" }
    points { 100 }
  end
end 