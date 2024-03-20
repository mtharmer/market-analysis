# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'bars/edit', type: :view do
  let(:bar) do
    create(:bar, day: 'Edit Day')
  end

  before do
    assign(:bar, bar)
  end

  it 'renders the edit bar form' do
    render

    assert_select 'form[action=?][method=?]', bar_path(bar), 'post' do
      assert_select 'input[name=?]', 'bar[day]'
    end
  end
end
