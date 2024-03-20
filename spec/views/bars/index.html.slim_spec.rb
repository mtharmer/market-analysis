# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'bars/index', type: :view do
  let(:bars) do
    create_list(:bar, 2, day: 'Index Day')
  end

  before do
    assign(:bars, bars)
  end

  it 'renders a list of bars' do # rubocop:disable RSpec/NoExpectationExample
  end
end
