require 'spec_helper'

describe "access_modules/index" do
  before(:each) do
    assign(:access_modules, [
      stub_model(AccessModule,
        :name => "Name",
        :is_active => false
      ),
      stub_model(AccessModule,
        :name => "Name",
        :is_active => false
      )
    ])
  end

  it "renders a list of access_modules" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
