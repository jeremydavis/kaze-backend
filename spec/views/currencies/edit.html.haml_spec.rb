require 'rails_helper'

RSpec.describe "currencies/edit", :type => :view do
  before(:each) do
    @currency = assign(:currency, Currency.create!(
      :shortname => "MyString",
      :longname => "MyString"
    ))
  end

  it "renders the edit currency form" do
    render

    assert_select "form[action=?][method=?]", currency_path(@currency), "post" do

      assert_select "input#currency_shortname[name=?]", "currency[shortname]"

      assert_select "input#currency_longname[name=?]", "currency[longname]"
    end
  end
end
