# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'bars/show', type: :view do
  before do
    assign(:bar, Bar.create!(
                   day: 'Day',
                   time: 'Time',
                   instrument: nil,
                   timeframe_measurement: 'Timeframe Measurement',
                   timeframe_value: 2,
                   high: '9.99',
                   low: '9.99',
                   open: '9.99',
                   close: '9.99',
                   volume: 3
                 ))
  end

  it 'renders attributes in <p>' do # rubocop:disable RSpec/ExampleLength
    render
    expect(rendered).to match(/Day/)
    expect(rendered).to match(/Time/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Timeframe Measurement/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/3/)
  end
end
