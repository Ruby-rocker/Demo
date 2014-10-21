require 'spec_helper'

describe "access_modules/edit" do
  before(:each) do
    @access_module = assign(:access_module, stub_model(AccessModule,
      :name => "MyString",
      :is_active => false
    ))
  end

  it "renders the edit access_module form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", access_module_path(@access_module), "post" do
      assert_select "input#access_module_name[name=?]", "access_module[name]"
      assert_select "input#access_module_is_active[name=?]", "access_module[is_active]"
    end
  end
end
