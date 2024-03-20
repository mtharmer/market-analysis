# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'market_profiles/index', type: :view do
  before do
    assign(:market_profiles, create_list(:market_profile, 2, day: 'This Day'))
  end

  it 'renders a list of market_profiles' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('This Day'.to_s), count: 2
  end
end
