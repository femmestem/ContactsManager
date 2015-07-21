require 'spec_helper'

describe Contact do
  it "has a valid factory" do
    expect(build(:contact)).to be_valid
  end

  it "is invalid without a firstname" do
    contact = Contact.new(firstname: nil)
    expect(contact).to have(1).errors_on(:firstname)
  end

  it "is invalid without a lastname" do
    contact = Contact.new(lastname: nil)
    expect(contact).to have(1).errors_on(:lastname)
  end

  it "is invalid without an email address" do
    contact = Contact.new(email: nil)
    expect(contact).to have(1).errors_on(:email)
  end

  it "is invalid with a duplicate email address" do
    create(:contact, email: "jdoe@test.com")
    contact = build(:contact, email: "jdoe@test.com")

    expect(contact).to have(1).errors_on(:email)
  end

  it "returns a contact's full name as string" do
    contact = build(
      :contact,
      firstname: "Jane",
      lastname: "Doe"
    )
    expect(contact.name).to eq "Jane Doe"
  end

  it "has three phone numbers" do
    expect(create(:contact).phones.count).to eq 3
  end

  # == Class methods and Scopes

  describe "filter last name by letter" do
    before :each do
      @smith = create(:contact, lastname: "Smith")
      @feaster = create(:contact, lastname: "Feaster")
      @fennimore = create(:contact, lastname: "Fennimore")
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
