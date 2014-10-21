require 'rails_helper'

RSpec.describe "beacon_ranges/index", :type => :view do
  before(:each) do
    assign(:beacon_ranges, [
      BeaconRange.create!(
        :name => "Name",
        :is_active => false
      ),
      BeaconRange.create!(
        :name => "Name",
        :is_active => false
      )
    ])
  end

  it "renders a list of beacon_ranges" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
