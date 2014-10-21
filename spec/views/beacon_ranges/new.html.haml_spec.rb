require 'rails_helper'

RSpec.describe "beacon_ranges/new", :type => :view do
  before(:each) do
    assign(:beacon_range, BeaconRange.new(
      :name => "MyString",
      :is_active => false
    ))
  end

  it "renders new beacon_range form" do
    render

    assert_select "form[action=?][method=?]", beacon_ranges_path, "post" do

      assert_select "input#beacon_range_name[name=?]", "beacon_range[name]"

      assert_select "input#beacon_range_is_active[name=?]", "beacon_range[is_active]"
    end
  end
end
