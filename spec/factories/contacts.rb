require 'faker'

FactoryGirl.define do
  factory :contact do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    sequence(:email) { |i| "tester_#{i}@email.com" }

    after(:build) do |contact|
      [:home_phone, :work_phone, :mobile_phone].each do |type|
        contact.phones << FactoryGirl.build(
          :phone,
          phone_type: type,
          contact: contact
          )
      end
    end

    factory :invalid_contact do
      firstname nil
    end
  end
end
