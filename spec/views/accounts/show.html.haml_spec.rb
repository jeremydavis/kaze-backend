require 'rails_helper'

RSpec.describe "accounts/show", :type => :view do
  before(:each) do
    @account = assign(:account, Account.create!(
      :account_number => "Account Number",
      :currency_id => 1,
      :balance => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Account Number/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/9.99/)
  end
end
