require 'rails_helper'

RSpec.describe "campaigns/new", :type => :view do
  before(:each) do
    assign(:campaign, Campaign.new(
      :title => "MyString",
      :name => "MyString",
      :description => "MyText",
      :store => nil,
      :ibeacon => nil,
      :category => nil,
      :is_active => false
    ))
  end

  it "renders new campaign form" do
    render

    assert_select "form[action=?][method=?]", campaigns_path, "post" do

      assert_select "input#campaign_title[name=?]", "campaign[title]"

      assert_select "input#campaign_name[name=?]", "campaign[name]"

      assert_select "textarea#campaign_description[name=?]", "campaign[description]"

      assert_select "input#campaign_store_id[name=?]", "campaign[store_id]"

      assert_select "input#campaign_ibeacon_id[name=?]", "campaign[ibeacon_id]"

      assert_select "input#campaign_category_id[name=?]", "campaign[category_id]"

      assert_select "input#campaign_is_active[name=?]", "campaign[is_active]"
    end
  end
end
