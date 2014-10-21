require 'rails_helper'

RSpec.describe "contacts/new", :type => :view do
  before(:each) do
    assign(:contact, Contact.new(
      :uuid => "MyString",
      :udid => "MyString",
      :first_name => "",
      :last_name => "MyString",
      :email_address => "MyString",
      :contact_no => "MyString",
      :latitude => "MyString",
      :longitude => "MyString"
    ))
  end

  it "renders new contact form" do
    render

    assert_select "form[action=?][method=?]", contacts_path, "post" do

      assert_select "input#contact_uuid[name=?]", "contact[uuid]"

      assert_select "input#contact_udid[name=?]", "contact[udid]"

      assert_select "input#contact_first_name[name=?]", "contact[first_name]"

      assert_select "input#contact_last_name[name=?]", "contact[last_name]"

      assert_select "input#contact_email_address[name=?]", "contact[email_address]"

      assert_select "input#contact_contact_no[name=?]", "contact[contact_no]"

      assert_select "input#contact_latitude[name=?]", "contact[latitude]"

      assert_select "input#contact_longitude[name=?]", "contact[longitude]"
    end
  end
end
