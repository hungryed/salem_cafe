# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:first_name) {|n| "J#{n}e"}
    sequence(:last_name) {|n| "Sm#{n}th"}
    sequence(:email) {|n| "j#{n}e@sm#{n}th.com"}
    phone_number '1111111111'
    receives_texts true
    password 'password'
    password_confirmation 'password'
  end
end
