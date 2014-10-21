require 'rails_helper'

RSpec.describe "ibeacons/edit", :type => :view do
  before(:each) do
    @ibeacon = assign(:ibeacon, Ibeacon.create!(
      :name => "MyString",
      :description => "MyText",
      :store => nil,
      :broadcast_id => "MyString",
      :is_active => false
    ))
  end

  it "renders the edit ibeacon form" do
    render

    assert_select "form[action=?][method=?]", ibeacon_path(@ibeacon), "post" do

      assert_select "input#ibeacon_name[name=?]", "ibeacon[name]"

      assert_select "textarea#ibeacon_description[name=?]", "ibeacon[description]"

      assert_select "input#ibeacon_store_id[name=?]", "ibeacon[store_id]"

      assert_select "input#ibeacon_broadcast_id[name=?]", "ibeacon[broadcast_id]"

      assert_select "input#ibeacon_is_active[name=?]", "ibeacon[is_active]"
    end
  end
end
