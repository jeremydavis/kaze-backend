require 'rails_helper'

RSpec.describe "accounts/new", :type => :view do
  before(:each) do
    assign(:account, Account.new(
      :account_number => "MyString",
      :currency_id => 1,
      :balance => "9.99"
    ))
  end

  it "renders new account form" do
    render

    assert_select "form[action=?][method=?]", accounts_path, "post" do

      assert_select "input#account_account_number[name=?]", "account[account_number]"

      assert_select "input#account_currency_id[name=?]", "account[currency_id]"

      assert_select "input#account_balance[name=?]", "account[balance]"
    end
  end
end
