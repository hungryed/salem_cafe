FactoryGirl.define do
  factory :food do
    association :food_category
    sequence(:name) { |n| "Chicken Brocolli #{n} Cheddar Bake" }
    description 'Delicious'
  end
end
