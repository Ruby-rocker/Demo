require 'spec_helper'

describe "access_modules/new" do
  before(:each) do
    assign(:access_module, stub_model(AccessModule,
      :name => "MyString",
      :is_active => false
    ).as_new_record)
  end

  it "renders new access_module form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", access_modules_path, "post" do
      assert_select "input#access_module_name[name=?]", "access_module[name]"
      assert_select "input#access_module_is_active[name=?]", "access_module[is_active]"
    end
  end
end
