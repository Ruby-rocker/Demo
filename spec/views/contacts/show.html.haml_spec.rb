require 'rails_helper'

RSpec.describe "contacts/show", :type => :view do
  before(:each) do
    @contact = assign(:contact, Contact.create!(
      :uuid => "Uuid",
      :udid => "Udid",
      :first_name => "",
      :last_name => "Last Name",
      :email_address => "Email Address",
      :contact_no => "Contact No",
      :latitude => "Latitude",
      :longitude => "Longitude"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Uuid/)
    expect(rendered).to match(/Udid/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Email Address/)
    expect(rendered).to match(/Contact No/)
    expect(rendered).to match(/Latitude/)
    expect(rendered).to match(/Longitude/)
  end
end
