FactoryGirl.define do
  factory :section do
    sequence(:name) {|n| "D#{n}li"}
    description 'Cold or Hot Sandwiches'

    start_time "11:00"
    end_time "14:00"
  end
end
