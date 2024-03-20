# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'market_profiles/edit', type: :view do
  let(:market_profile) do
    create(:market_profile, day: 'Edit Day')
  end

  before do
    assign(:market_profile, market_profile)
  end

  it 'renders the edit market_profile form' do
    render

    assert_select 'form[action=?][method=?]', market_profile_path(market_profile), 'post' do
      assert_select 'input[name=?]', 'market_profile[day]'
    end
  end
end
