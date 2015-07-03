require 'spec_helper'

describe Contact do
  it "is valid with a firstname, lastname, and email" do
    contact = Contact.new(
      firstname: "Christine",
      lastname: "Feaster",
      email: "c.feaster@test.com"
      )

    expect(contact).to be_valid
  end

  it "is invalid without a firstname" do
    contact = Contact.new(
      firstname: nil
      )

    expect(contact).to have(1).errors_on(:firstname)
  end

  it "is invalid without a lastname" do
      contact = Contact.new(
      lastname: nil
      )

    expect(contact).to have(1).errors_on(:lastname)
  end

  it "is invalid without an email address" do
    contact = Contact.new(
      email: nil
      )

    expect(contact).to have(1).errors_on(:email)
  end

  it "is invalid with a duplicate email address" do
    john = Contact.create(
      firstname: "John",
      lastname: "Doe",
      email: "jdoe@test.com"
      )
    jane = Contact.new(
      firstname: "Jane",
      lastname: "Doe",
      email: "jdoe@test.com"
      )

    expect(jane).to have(1).errors_on(:email)
  end

  it "returns a contact's full name as string" do
    contact = Contact.new(
      firstname: "Jane",
      lastname: "Doe",
      email: "jdoe@test.com"
      )

    expect(contact.name).to eq "Jane Doe"
  end

end
