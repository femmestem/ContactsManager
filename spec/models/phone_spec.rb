require 'spec_helper'

describe Phone do
  it "does not allow duplicate phone numbers per contact" do
    jane = create(:contact)
    jane_home_phone = create(
      :home_phone,
      contact: jane,
      phone: "555-555-1234"
      )
    jane_mobile_phone = build(
      :mobile_phone,
      contact: jane,
      phone: "555-555-1234"
      )

    expect(jane_mobile_phone).to have(1).errors_on(:phone)
  end

  it "allows two contacts to share a phone number" do
    jane_phone = create(
      :home_phone,
      phone: "555-555-1234"
      )
    john_phone = build(
      :home_phone,
      phone: "555-555-1234"
      )

    expect(john_phone).to be_valid
  end
end
