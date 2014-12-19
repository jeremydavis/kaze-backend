require 'rails_helper'

RSpec.describe "payees/index", :type => :view do
  before(:each) do
    assign(:payees, [
      Payee.create!(
        :nickname => "Nickname",
        :account_holder => "Account Holder",
        :account_number => 1,
        :bank_name => "Bank Name",
        :branch_name => "Branch Name"
      ),
      Payee.create!(
        :nickname => "Nickname",
        :account_holder => "Account Holder",
        :account_number => 1,
        :bank_name => "Bank Name",
        :branch_name => "Branch Name"
      )
    ])
  end

  it "renders a list of payees" do
    render
    assert_select "tr>td", :text => "Nickname".to_s, :count => 2
    assert_select "tr>td", :text => "Account Holder".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Bank Name".to_s, :count => 2
    assert_select "tr>td", :text => "Branch Name".to_s, :count => 2
  end
end
