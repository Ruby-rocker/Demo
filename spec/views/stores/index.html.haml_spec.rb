require 'rails_helper'

RSpec.describe "stores/index", :type => :view do
  before(:each) do
    assign(:stores, [
      Store.create!(
        :name => "Name",
        :location => nil,
        :is_active => false
      ),
      Store.create!(
        :name => "Name",
        :location => nil,
        :is_active => false
      )
    ])
  end

  it "renders a list of stores" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
