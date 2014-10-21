require 'rails_helper'

RSpec.describe "contacts/index", :type => :view do
  before(:each) do
    assign(:contacts, [
      Contact.create!(
        :uuid => "Uuid",
        :udid => "Udid",
        :first_name => "",
        :last_name => "Last Name",
        :email_address => "Email Address",
        :contact_no => "Contact No",
        :latitude => "Latitude",
        :longitude => "Longitude"
      ),
      Contact.create!(
        :uuid => "Uuid",
        :udid => "Udid",
        :first_name => "",
        :last_name => "Last Name",
        :email_address => "Email Address",
        :contact_no => "Contact No",
        :latitude => "Latitude",
        :longitude => "Longitude"
      )
    ])
  end

  it "renders a list of contacts" do
    render
    assert_select "tr>td", :text => "Uuid".to_s, :count => 2
    assert_select "tr>td", :text => "Udid".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email Address".to_s, :count => 2
    assert_select "tr>td", :text => "Contact No".to_s, :count => 2
    assert_select "tr>td", :text => "Latitude".to_s, :count => 2
    assert_select "tr>td", :text => "Longitude".to_s, :count => 2
  end
end
