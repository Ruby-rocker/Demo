require 'spec_helper'

describe "access_modules/show" do
  before(:each) do
    @access_module = assign(:access_module, stub_model(AccessModule,
      :name => "Name",
      :is_active => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/false/)
  end
end
