require 'rails_helper'

RSpec.describe "accounts/index", :type => :view do
  before(:each) do
    assign(:accounts, [
      Account.create!(
        :account_number => "Account Number",
        :currency_id => 1,
        :balance => "9.99"
      ),
      Account.create!(
        :account_number => "Account Number",
        :currency_id => 1,
        :balance => "9.99"
      )
    ])
  end

  it "renders a list of accounts" do
    render
    assert_select "tr>td", :text => "Account Number".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
