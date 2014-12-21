require 'rails_helper'

RSpec.describe "transfers/index", :type => :view do
  before(:each) do
    assign(:transfers, [
      Transfer.create!(
        :account_id => 1,
        :payee_id => 2,
        :currency_id => 3,
        :value => "9.99",
        :description => "MyText",
        :repeat => false,
        :status => "Status",
        :transaction_password_valid => false,
        :one_time_password_valid => false
      ),
      Transfer.create!(
        :account_id => 1,
        :payee_id => 2,
        :currency_id => 3,
        :value => "9.99",
        :description => "MyText",
        :repeat => false,
        :status => "Status",
        :transaction_password_valid => false,
        :one_time_password_valid => false
      )
    ])
  end

  it "renders a list of transfers" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
