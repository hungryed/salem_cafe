FactoryGirl.define do
  factory :food_category do
    association :section
    name 'Entree'
    description 'Main Course'
  end
end
