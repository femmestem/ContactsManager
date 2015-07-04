require 'spec_helper'

describe Contact do
  it "has a valid factory" do
    expect(FactoryGirl.build(:contact)).to be_valid
  end

  it "is valid with a firstname, lastname, and email" do
    contact = Contact.new(
      firstname: "Christine",
      lastname: "Feaster",
      email: "cfeaster@test.com"
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

  # == Class methods and Scopes

  it "returns a sorted array of results that match" do
    smith = Contact.create(
      firstname: "John",
      lastname: "Smith",
      email: "jsmith@test.com"
      )
    feaster = Contact.create(
      firstname: "Christine",
      lastname: "Feaster",
      email: "cfeaster@test.com"
      )
    fennimore = Contact.create(
      firstname: "Neal",
      lastname: "Fennimore",
      email: "nfennimore@test.com"
      )

    expect(Contact.by_letter("F")).to eq [feaster, fennimore]
  end

  describe "filter last name by letter" do
    before :each do
      @smith = Contact.create(
        firstname: "John",
        lastname: "Smith",
        email: "jsmith@test.com"
        )
      @feaster = Contact.create(
        firstname: "Christine",
        lastname: "Feaster",
        email: "cfeaster@test.com"
        )
      @fennimore = Contact.create(
        firstname: "Neal",
        lastname: "Fennimore",
        email: "nfennimore@test.com"
        )
    end

    context "matching letters" do
      it "returns a sorted array of results that match" do
        expect(Contact.by_letter("F")).to eq [@feaster, @fennimore]
      end
    end

    context "non-matching letters" do
      it "returns a sorted array of results that match" do
        expect(Contact.by_letter("F")).to_not include @smith
      end
    end

  end

end
