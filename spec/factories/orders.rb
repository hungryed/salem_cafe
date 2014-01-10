FactoryGirl.define do
  factory :order do
    association :user
    association :section
    association :food

    arrival_time "13:55"
  end
end
