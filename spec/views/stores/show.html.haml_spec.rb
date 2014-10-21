require 'rails_helper'

RSpec.describe "stores/show", :type => :view do
  before(:each) do
    @store = assign(:store, Store.create!(
      :name => "Name",
      :location => nil,
      :is_active => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
