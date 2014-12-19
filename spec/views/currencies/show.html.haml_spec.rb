require 'rails_helper'

RSpec.describe "currencies/show", :type => :view do
  before(:each) do
    @currency = assign(:currency, Currency.create!(
      :shortname => "Shortname",
      :longname => "Longname"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Shortname/)
    expect(rendered).to match(/Longname/)
  end
end
