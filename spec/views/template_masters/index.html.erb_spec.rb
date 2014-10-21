require 'rails_helper'

RSpec.describe "template_masters/index", :type => :view do
  before(:each) do
    assign(:template_masters, [
      TemplateMaster.create!(
        :name => "Name",
        :description => "MyText"
      ),
      TemplateMaster.create!(
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of template_masters" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
