require 'rails_helper'

RSpec.describe "transfers/new", :type => :view do
  before(:each) do
    assign(:transfer, Transfer.new(
      :account_id => 1,
      :payee_id => 1,
      :currency_id => 1,
      :value => "9.99",
      :description => "MyText",
      :repeat => false,
      :status => "MyString",
      :transaction_password_valid => false,
      :one_time_password_valid => false
    ))
  end

  it "renders new transfer form" do
    render

    assert_select "form[action=?][method=?]", transfers_path, "post" do

      assert_select "input#transfer_account_id[name=?]", "transfer[account_id]"

      assert_select "input#transfer_payee_id[name=?]", "transfer[payee_id]"

      assert_select "input#transfer_currency_id[name=?]", "transfer[currency_id]"

      assert_select "input#transfer_value[name=?]", "transfer[value]"

      assert_select "textarea#transfer_description[name=?]", "transfer[description]"

      assert_select "input#transfer_repeat[name=?]", "transfer[repeat]"

      assert_select "input#transfer_status[name=?]", "transfer[status]"

      assert_select "input#transfer_transaction_password_valid[name=?]", "transfer[transaction_password_valid]"

      assert_select "input#transfer_one_time_password_valid[name=?]", "transfer[one_time_password_valid]"
    end
  end
end
