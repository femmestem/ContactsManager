FactoryGirl.define do
  factory :contact do
    firstname "Jane"
    lastname "Doe"
    sequence(:email) { |i| "janedoe#{i}@test.com" }
  end
end
