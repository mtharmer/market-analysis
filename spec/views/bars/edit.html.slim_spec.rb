require 'rails_helper'

RSpec.describe "bars/edit", type: :view do
  let(:bar) {
    Bar.create!(
      day: "MyString",
      time: "MyString",
      instrument: nil,
      timeframe_measurement: "MyString",
      timeframe_value: 1,
      high: "9.99",
      low: "9.99",
      open: "9.99",
      close: "9.99",
      volume: 1
    )
  }

  before(:each) do
    assign(:bar, bar)
  end

  it "renders the edit bar form" do
    render

    assert_select "form[action=?][method=?]", bar_path(bar), "post" do

      assert_select "input[name=?]", "bar[day]"

      assert_select "input[name=?]", "bar[time]"

      assert_select "input[name=?]", "bar[instrument_id]"

      assert_select "input[name=?]", "bar[timeframe_measurement]"

      assert_select "input[name=?]", "bar[timeframe_value]"

      assert_select "input[name=?]", "bar[high]"

      assert_select "input[name=?]", "bar[low]"

      assert_select "input[name=?]", "bar[open]"

      assert_select "input[name=?]", "bar[close]"

      assert_select "input[name=?]", "bar[volume]"
    end
  end
end
