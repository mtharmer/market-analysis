# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MarketProfile, type: :model do
  let(:instrument) { create(:instrument, tick_size: 0.25) }

  describe 'create_tpos' do
    let(:day) { '04/01/2024' }
    let(:existing_profile) { create(:market_profile, instrument: instrument) }

    it 'returns if no tpo data' do
      obj = described_class.new(instrument: instrument, day: day)
      allow(obj).to receive(:tpo_hash).and_return({})
      expect(obj.create_tpos).to be_nil
    end

    it 'calls on tpo_hash' do
      obj = described_class.new(instrument: instrument, day: day)
      allow(obj).to receive(:tpo_hash).and_return({})
      obj.create_tpos
      expect(obj).to have_received(:tpo_hash)
    end

    it 'creates tpos from tpo_hash' do
      tpos = { 10.0 => %w[A B C], 10.25 => %w[A B] }
      allow(existing_profile).to receive(:tpo_hash).and_return(tpos)
      expect { existing_profile.create_tpos }.to change(Tpo, :count).by(2)
    end

    context 'point of control and total tpos' do
      it 'assigns the point of control and total tpos' do
        tpos = { 10.0 => %w[A B C], 10.25 => %w[A B] }
        allow(existing_profile).to receive(:tpo_hash).and_return(tpos)
        existing_profile.create_tpos
        expect(existing_profile.point_of_control).to eq(10.0)
        expect(existing_profile.total_tpos).to eq(5)
      end

      it 'assigns the higher of two matching points of control' do
        tpos = { 10.0 => %w[A], 10.25 => %w[A B C], 10.5 => %w[A B C], 10.75 => %w[B C] }
        allow(existing_profile).to receive(:tpo_hash).and_return(tpos)
        existing_profile.create_tpos
        expect(existing_profile.point_of_control).to eq(10.5)
        expect(existing_profile.total_tpos).to eq(9)
      end
    end
  end

  describe 'calculate_value_area' do
    let(:day) { '04/01/2024' }
    let(:existing_profile) do
      create(:market_profile, day: day, instrument: instrument,
                              point_of_control: 20.25, total_tpos: 10)
    end

    before do
      create(:tpo, market_profile: existing_profile, price: 20.0, letters: %w[A B])
      create(:tpo, market_profile: existing_profile, price: 20.25, letters: %w[A B C])
      create(:tpo, market_profile: existing_profile, price: 20.5, letters: %w[B C])
      create(:tpo, market_profile: existing_profile, price: 20.75, letters: %w[B C])
      create(:tpo, market_profile: existing_profile, price: 22.0, letters: %w[C])
    end

    it 'sets intial values to the point of control' do
      allow(existing_profile).to receive(:tpo_point_of_control_length).and_return(3)
      allow(existing_profile).to receive(:search_for_value_limits)
      existing_profile.calculate_value_area
      expect(existing_profile).to have_received(:search_for_value_limits).with(3, 7, 20.25, 20.25)
    end

    it 'calculates the valuea areas' do
      allow(existing_profile).to receive(:tpo_point_of_control_length).and_return(3)
      existing_profile.calculate_value_area
      expect(existing_profile.value_area_high).to eq(20.5)
      expect(existing_profile.value_area_low).to eq(20.0)
    end
  end
end
