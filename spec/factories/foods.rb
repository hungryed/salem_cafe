FactoryGirl.define do
  factory :food do
    association :food_category
    association :section
    sequence(:name) { |n| "Chicken Brocolli #{n} Cheddar Bake" }
    description 'Delicious'
  end
end
