FactoryGirl.define do
  factory :order do
    association :user
    association :food

    arrival_time "13:55"
  end
end
