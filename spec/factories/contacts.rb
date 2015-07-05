FactoryGirl.define do
  factory :contact do
    firstname "Jane"
    lastname "Doe"
    sequence(:email) { |i| "janedoe#{i}@test.com" }

    after(:build) do |contact|
      [:home_phone, :work_phone, :mobile_phone].each do |type|
        contact.phones << FactoryGirl.build(
          :phone,
          phone_type: type,
          contact: contact
          )
      end
    end
  end
end
