# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'instruments/new', type: :view do
  before do
    assign(:instrument, Instrument.new(
                          symbol: 'MyString',
                          exchange: 'MyString',
                          asset_class: 'MyString'
                        ))
  end

  it 'renders new instrument form' do # rubocop:disable RSpec/ExampleLength
    render

    assert_select 'form[action=?][method=?]', instruments_path, 'post' do
      assert_select 'input[name=?]', 'instrument[symbol]'

      assert_select 'input[name=?]', 'instrument[exchange]'

      assert_select 'input[name=?]', 'instrument[asset_class]'
    end
  end
end
