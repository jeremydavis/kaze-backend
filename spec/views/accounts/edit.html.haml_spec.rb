require 'rails_helper'

RSpec.describe "accounts/edit", :type => :view do
  before(:each) do
    @account = assign(:account, Account.create!(
      :account_number => "MyString",
      :currency_id => 1,
      :balance => "9.99"
    ))
  end

  it "renders the edit account form" do
    render

    assert_select "form[action=?][method=?]", account_path(@account), "post" do

      assert_select "input#account_account_number[name=?]", "account[account_number]"

      assert_select "input#account_currency_id[name=?]", "account[currency_id]"

      assert_select "input#account_balance[name=?]", "account[balance]"
    end
  end
end
