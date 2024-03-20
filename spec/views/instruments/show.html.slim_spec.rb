# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'instruments/show', type: :view do
  before do
    assign(:instrument, Instrument.create!(
                          symbol: 'Symbol',
                          exchange: 'Exchange',
                          asset_class: 'Asset Class'
                        ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Symbol/)
    expect(rendered).to match(/Exchange/)
    expect(rendered).to match(/Asset Class/)
  end
end
