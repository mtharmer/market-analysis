# frozen_string_literal: true

require 'rails_helper'
RSpec.describe GenerateMarketProfiles do
  describe 'call' do
    it 'does nothing if there are no instruments' do
      expect { described_class.new.call }.not_to change(MarketProfile, :count)
    end

    it 'does nothing if there are no bars' do
      create(:instrument)
      expect { described_class.new.call }.not_to change(MarketProfile, :count)
    end

    context 'with valid data' do
      let!(:instrument) { create(:instrument, id: 1000) }

      before do
        create(:bar, day: '01/01/2024', instrument: instrument)
      end

      it 'calls CreateMarketProfileJob if instrument and bars are found' do
        allow(CreateMarketProfileJob).to receive(:perform_async)
        described_class.new.call
        expect(CreateMarketProfileJob).to have_received(:perform_async).with(1000, '01/01/2024')
      end
    end
  end
end
