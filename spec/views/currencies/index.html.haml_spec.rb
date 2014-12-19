require 'rails_helper'

RSpec.describe "currencies/index", :type => :view do
  before(:each) do
    assign(:currencies, [
      Currency.create!(
        :shortname => "Shortname",
        :longname => "Longname"
      ),
      Currency.create!(
        :shortname => "Shortname",
        :longname => "Longname"
      )
    ])
  end

  it "renders a list of currencies" do
    render
    assert_select "tr>td", :text => "Shortname".to_s, :count => 2
    assert_select "tr>td", :text => "Longname".to_s, :count => 2
  end
end
