require 'rails_helper'

RSpec.describe "stores/new", :type => :view do
  before(:each) do
    assign(:store, Store.new(
      :name => "MyString",
      :location => nil,
      :is_active => false
    ))
  end

  it "renders new store form" do
    render

    assert_select "form[action=?][method=?]", stores_path, "post" do

      assert_select "input#store_name[name=?]", "store[name]"

      assert_select "input#store_location_id[name=?]", "store[location_id]"

      assert_select "input#store_is_active[name=?]", "store[is_active]"
    end
  end
end
