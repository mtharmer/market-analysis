require 'rails_helper'

RSpec.describe "bars/index", type: :view do
  before(:each) do
    assign(:bars, [
      Bar.create!(
        day: "Day",
        time: "Time",
        instrument: nil,
        timeframe_measurement: "Timeframe Measurement",
        timeframe_value: 2,
        high: "9.99",
        low: "9.99",
        open: "9.99",
        close: "9.99",
        volume: 3
      ),
      Bar.create!(
        day: "Day",
        time: "Time",
        instrument: nil,
        timeframe_measurement: "Timeframe Measurement",
        timeframe_value: 2,
        high: "9.99",
        low: "9.99",
        open: "9.99",
        close: "9.99",
        volume: 3
      )
    ])
  end

  it "renders a list of bars" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Day".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Time".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Timeframe Measurement".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
  end
end
