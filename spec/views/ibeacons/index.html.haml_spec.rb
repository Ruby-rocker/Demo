require 'rails_helper'

RSpec.describe "ibeacons/index", :type => :view do
  before(:each) do
    assign(:ibeacons, [
      Ibeacon.create!(
        :name => "Name",
        :description => "MyText",
        :store => nil,
        :broadcast_id => "Broadcast",
        :is_active => false
      ),
      Ibeacon.create!(
        :name => "Name",
        :description => "MyText",
        :store => nil,
        :broadcast_id => "Broadcast",
        :is_active => false
      )
    ])
  end

  it "renders a list of ibeacons" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Broadcast".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
