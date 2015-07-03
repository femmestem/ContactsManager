require 'spec_helper'

describe Phone do
  it "does not allow duplicate phone numbers per contact" do
    contact = Contact.create(
      firstname: "John",
      lastname: "Doe",
      email: "johndoe@test.com"
      )
    contact.phones.create(
      phone_type: "home",
      phone: "555-555-1234"
      )
    mobile_phone = contact.phones.build(
      phone_type: "mobile",
      phone: "555-555-1234"
      )

    expect(mobile_phone).to have(1).errors_on(:phone)
  end

  it "allows two contacts to share a phone number" do
    john = Contact.create(
      firstname: "John",
      lastname: "Doe",
      email: "johndoe@test.com"
      )
    john.phones.create(
      phone_type: "home",
      phone: "555-555-1234"
      )
    jane = Contact.new
    jane_phone = jane.phones.build(
      phone_type: "home",
      phone: "555-555-1234"
      )

    expect(jane_phone).to be_valid
  end
end
