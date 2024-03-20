# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/bars', type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Bar. As you add validations to Bar, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Bar.create! valid_attributes
      get bars_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      bar = Bar.create! valid_attributes
      get bar_url(bar)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_bar_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      bar = Bar.create! valid_attributes
      get edit_bar_url(bar)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Bar' do
        expect do
          post bars_url, params: { bar: valid_attributes }
        end.to change(Bar, :count).by(1)
      end

      it 'redirects to the created bar' do
        post bars_url, params: { bar: valid_attributes }
        expect(response).to redirect_to(bar_url(Bar.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Bar' do
        expect do
          post bars_url, params: { bar: invalid_attributes }
        end.not_to change(Bar, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post bars_url, params: { bar: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested bar' do
        bar = Bar.create! valid_attributes
        patch bar_url(bar), params: { bar: new_attributes }
        bar.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the bar' do
        bar = Bar.create! valid_attributes
        patch bar_url(bar), params: { bar: new_attributes }
        bar.reload
        expect(response).to redirect_to(bar_url(bar))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        bar = Bar.create! valid_attributes
        patch bar_url(bar), params: { bar: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested bar' do
      bar = Bar.create! valid_attributes
      expect do
        delete bar_url(bar)
      end.to change(Bar, :count).by(-1)
    end

    it 'redirects to the bars list' do
      bar = Bar.create! valid_attributes
      delete bar_url(bar)
      expect(response).to redirect_to(bars_url)
    end
  end
end
