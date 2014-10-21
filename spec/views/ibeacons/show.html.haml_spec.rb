require 'rails_helper'

RSpec.describe "ibeacons/show", :type => :view do
  before(:each) do
    @ibeacon = assign(:ibeacon, Ibeacon.create!(
      :name => "Name",
      :description => "MyText",
      :store => nil,
      :broadcast_id => "Broadcast",
      :is_active => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Broadcast/)
    expect(rendered).to match(/false/)
  end
end
