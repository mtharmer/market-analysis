# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MarketProfileBuilder do
  let(:instrument) { create(:instrument) }
  let(:existing_day) { '01/01/2024' }
  let(:new_day) { '02/01/2024' }

  describe 'call' do
    it 'returns if a profile already exists' do
      create(:market_profile, instrument: instrument, day: existing_day)
      expect { described_class.new(existing_day, instrument.id).call }.to raise_error ActiveRecord::RecordNotUnique
    end

    it 'returns if no bars are found', skip: 'Bad test' do
      obj = described_class.new(new_day, instrument.id)
      expect { obj.call }.not_to change(MarketProfile, :count)
    end

    it 'returns if less than 3 bars are found', skip: 'Bad test' do
      obj = described_class.new(new_day, instrument.id)
      allow(obj).to receive(:profile_bars).and_return(%w[item1 item2])
      expect { obj.call }.not_to change(MarketProfile, :count)
    end

    it 'calls create if bars are found', skip: 'Bad test' do
      obj = described_class.new(new_day, instrument.id)
      allow(obj).to receive_messages(profile_bars: %w[item1 item2 item3], initial_attributes: {
                                       instrument: instrument
                                     })
      expect { obj.call }.to change(MarketProfile, :count)
    end
  end

  describe 'initial_attributes' do
    let(:bars) { build_list(:bar, 2, day: new_day, instrument: instrument) }

    it 'creates initial attributes based on instance variables' do
      obj = described_class.new(new_day, instrument.id)
      obj.instance_variable_set(:@bars, bars)
      attrs = obj.initial_attributes
      expect(attrs[:day]).to eq(new_day)
    end
  end
end
