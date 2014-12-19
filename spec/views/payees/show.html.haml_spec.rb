require 'rails_helper'

RSpec.describe "payees/show", :type => :view do
  before(:each) do
    @payee = assign(:payee, Payee.create!(
      :nickname => "Nickname",
      :account_holder => "Account Holder",
      :account_number => 1,
      :bank_name => "Bank Name",
      :branch_name => "Branch Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nickname/)
    expect(rendered).to match(/Account Holder/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Bank Name/)
    expect(rendered).to match(/Branch Name/)
  end
end
