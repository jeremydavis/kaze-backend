require 'rails_helper'

RSpec.describe "payees/edit", :type => :view do
  before(:each) do
    @payee = assign(:payee, Payee.create!(
      :nickname => "MyString",
      :account_holder => "MyString",
      :account_number => 1,
      :bank_name => "MyString",
      :branch_name => "MyString"
    ))
  end

  it "renders the edit payee form" do
    render

    assert_select "form[action=?][method=?]", payee_path(@payee), "post" do

      assert_select "input#payee_nickname[name=?]", "payee[nickname]"

      assert_select "input#payee_account_holder[name=?]", "payee[account_holder]"

      assert_select "input#payee_account_number[name=?]", "payee[account_number]"

      assert_select "input#payee_bank_name[name=?]", "payee[bank_name]"

      assert_select "input#payee_branch_name[name=?]", "payee[branch_name]"
    end
  end
end
