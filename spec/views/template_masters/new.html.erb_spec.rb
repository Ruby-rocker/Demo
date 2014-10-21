require 'rails_helper'

RSpec.describe "template_masters/new", :type => :view do
  before(:each) do
    assign(:template_master, TemplateMaster.new(
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new template_master form" do
    render

    assert_select "form[action=?][method=?]", template_masters_path, "post" do

      assert_select "input#template_master_name[name=?]", "template_master[name]"

      assert_select "textarea#template_master_description[name=?]", "template_master[description]"
    end
  end
end
