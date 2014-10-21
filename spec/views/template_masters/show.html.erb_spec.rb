require 'rails_helper'

RSpec.describe "template_masters/show", :type => :view do
  before(:each) do
    @template_master = assign(:template_master, TemplateMaster.create!(
      :name => "Name",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
