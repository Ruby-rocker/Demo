require 'rails_helper'

RSpec.describe "campaigns/index", :type => :view do
  before(:each) do
    assign(:campaigns, [
      Campaign.create!(
        :title => "Title",
        :name => "Name",
        :description => "MyText",
        :store => nil,
        :ibeacon => nil,
        :category => nil,
        :is_active => false
      ),
      Campaign.create!(
        :title => "Title",
        :name => "Name",
        :description => "MyText",
        :store => nil,
        :ibeacon => nil,
        :category => nil,
        :is_active => false
      )
    ])
  end

  it "renders a list of campaigns" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
