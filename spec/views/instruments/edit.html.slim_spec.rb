require 'rails_helper'

RSpec.describe "instruments/edit", type: :view do
  let(:instrument) {
    Instrument.create!(
      symbol: "MyString",
      exchange: "MyString",
      asset_class: "MyString"
    )
  }

  before(:each) do
    assign(:instrument, instrument)
  end

  it "renders the edit instrument form" do
    render

    assert_select "form[action=?][method=?]", instrument_path(instrument), "post" do

      assert_select "input[name=?]", "instrument[symbol]"

      assert_select "input[name=?]", "instrument[exchange]"

      assert_select "input[name=?]", "instrument[asset_class]"
    end
  end
end
