require 'rails_helper'

RSpec.describe "locations/edit", :type => :view do
  before(:each) do
    @location = assign(:location, Location.create!(
      :name => "MyString",
      :is_active => false
    ))
  end

  it "renders the edit location form" do
    render

    assert_select "form[action=?][method=?]", location_path(@location), "post" do

      assert_select "input#location_name[name=?]", "location[name]"

      assert_select "input#location_is_active[name=?]", "location[is_active]"
    end
  end
end
