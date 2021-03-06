require 'rails_helper'

RSpec.describe "template_masters/edit", :type => :view do
  before(:each) do
    @template_master = assign(:template_master, TemplateMaster.create!(
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit template_master form" do
    render

    assert_select "form[action=?][method=?]", template_master_path(@template_master), "post" do

      assert_select "input#template_master_name[name=?]", "template_master[name]"

      assert_select "textarea#template_master_description[name=?]", "template_master[description]"
    end
  end
end
