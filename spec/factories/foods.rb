FactoryGirl.define do
  factory :food do
    sequence(:name) { |n| "Chicken Brocolli #{n} Cheddar Bake" }
    description 'Delicious'
  end
end
