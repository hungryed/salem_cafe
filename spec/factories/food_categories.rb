FactoryGirl.define do
  factory :food_category do
    association :section
    sequence(:name) { |n| "Ent#{n}ree" }
    description 'Main Course'
    multiple false
  end
end
