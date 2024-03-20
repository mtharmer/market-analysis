# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'instruments/index', type: :view do
  before do
    assign(:instruments, [
             Instrument.create!(
               symbol: 'Symbol',
               exchange: 'Exchange',
               asset_class: 'Asset Class'
             ),
             Instrument.create!(
               symbol: 'Symbol',
               exchange: 'Exchange',
               asset_class: 'Asset Class'
             )
           ])
  end

  it 'renders a list of instruments' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Symbol'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Exchange'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Asset Class'.to_s), count: 2
  end
end
