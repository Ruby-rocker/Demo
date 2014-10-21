require 'rails_helper'

RSpec.describe "beacon_ranges/show", :type => :view do
  before(:each) do
    @beacon_range = assign(:beacon_range, BeaconRange.create!(
      :name => "Name",
      :is_active => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/false/)
  end
end
