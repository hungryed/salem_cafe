FactoryGirl.define do
  factory :order_food do
    association :food
    association :order
  end
end
