require 'rails_helper'

RSpec.describe "bars/new", type: :view do
  before(:each) do
    assign(:bar, Bar.new(
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
    ))
  end

  it "renders new bar form" do
    render

    assert_select "form[action=?][method=?]", bars_path, "post" do

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
