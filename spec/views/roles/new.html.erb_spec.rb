require 'spec_helper'

describe "roles/new" do
  before(:each) do
    assign(:role, stub_model(Role,
      :name => "MyString",
      :description => "MyText",
      :code => 1,
      :is_active => false,
      :access_module => nil
    ).as_new_record)
  end

  it "renders new role form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", roles_path, "post" do
      assert_select "input#role_name[name=?]", "role[name]"
      assert_select "textarea#role_description[name=?]", "role[description]"
      assert_select "input#role_code[name=?]", "role[code]"
      assert_select "input#role_is_active[name=?]", "role[is_active]"
      assert_select "input#role_access_module[name=?]", "role[access_module]"
    end
  end
end
