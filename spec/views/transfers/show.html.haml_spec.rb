require 'rails_helper'

RSpec.describe "transfers/show", :type => :view do
  before(:each) do
    @transfer = assign(:transfer, Transfer.create!(
      :account_id => 1,
      :payee_id => 2,
      :currency_id => 3,
      :value => "9.99",
      :description => "MyText",
      :repeat => false,
      :status => "Status",
      :transaction_password_valid => false,
      :otp_password_valid => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
