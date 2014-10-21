require 'rails_helper'

RSpec.describe "beacon_ranges/edit", :type => :view do
  before(:each) do
    @beacon_range = assign(:beacon_range, BeaconRange.create!(
      :name => "MyString",
      :is_active => false
    ))
  end

  it "renders the edit beacon_range form" do
    render

    assert_select "form[action=?][method=?]", beacon_range_path(@beacon_range), "post" do

      assert_select "input#beacon_range_name[name=?]", "beacon_range[name]"

      assert_select "input#beacon_range_is_active[name=?]", "beacon_range[is_active]"
    end
  end
end
