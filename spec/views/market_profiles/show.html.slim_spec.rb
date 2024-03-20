# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'market_profiles/show', type: :view do
  before do
    assign(:market_profile, create(:market_profile, day: 'Show Day'))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Show Day/)
  end
end
