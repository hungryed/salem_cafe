FactoryGirl.define do
  factory :order do
    association :user
    association :section

    arrival_time "13:55"
  end
end
