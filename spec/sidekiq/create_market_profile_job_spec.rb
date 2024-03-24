# frozen_string_literal: true

require 'rails_helper'
RSpec.describe CreateMarketProfileJob, type: :job do
  let(:instrument_id) { 1001 }
  let(:day) { '02/01/2024' }

  it 'does nothing with bad parameters' do
    expect { described_class.perform_async }.not_to change(MarketProfile, :count)
  end

  context 'with valid parameters' do
    before do
      create(:instrument, id: instrument_id)
      create(:bar, day: day)
    end

    it 'enqueues a job in sidekiq' do
      described_class.clear
      expect(described_class.jobs.size).to be(0)
      expect { described_class.perform_async(instrument_id, day) }
        .to change(described_class.jobs, :size).by(1)
    end
  end
end
