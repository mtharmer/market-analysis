# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'market_profiles/new', type: :view do
  before do
    assign(:market_profile, MarketProfile.new(
                              day: 'MyString',
                              instrument: nil,
                              high: '9.99',
                              low: '9.99',
                              open: '9.99',
                              close: '9.99',
                              initial_balance_high: '9.99',
                              initial_balance_low: '9.99',
                              value_area_high: '9.99',
                              value_area_low: '9.99',
                              point_of_control: '9.99',
                              day_type: 'MyString',
                              opening_type: 'MyString'
                            ))
  end

  it 'renders new market_profile form' do # rubocop:disable RSpec/ExampleLength
    render

    assert_select 'form[action=?][method=?]', market_profiles_path, 'post' do
      assert_select 'input[name=?]', 'market_profile[day]'

      assert_select 'input[name=?]', 'market_profile[instrument_id]'

      assert_select 'input[name=?]', 'market_profile[high]'

      assert_select 'input[name=?]', 'market_profile[low]'

      assert_select 'input[name=?]', 'market_profile[open]'

      assert_select 'input[name=?]', 'market_profile[close]'

      assert_select 'input[name=?]', 'market_profile[initial_balance_high]'

      assert_select 'input[name=?]', 'market_profile[initial_balance_low]'

      assert_select 'input[name=?]', 'market_profile[value_area_high]'

      assert_select 'input[name=?]', 'market_profile[value_area_low]'

      assert_select 'input[name=?]', 'market_profile[point_of_control]'

      assert_select 'input[name=?]', 'market_profile[day_type]'

      assert_select 'input[name=?]', 'market_profile[opening_type]'
    end
  end
end
