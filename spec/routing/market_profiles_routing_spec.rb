# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MarketProfilesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/market_profiles').to route_to('market_profiles#index')
    end

    it 'routes to #new' do
      expect(get: '/market_profiles/new').to route_to('market_profiles#new')
    end

    it 'routes to #show' do
      expect(get: '/market_profiles/1').to route_to('market_profiles#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/market_profiles/1/edit').to route_to('market_profiles#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/market_profiles').to route_to('market_profiles#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/market_profiles/1').to route_to('market_profiles#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/market_profiles/1').to route_to('market_profiles#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/market_profiles/1').to route_to('market_profiles#destroy', id: '1')
    end
  end
end
