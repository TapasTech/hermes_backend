# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PutTokensController, type: :controller do
  describe 'GET show' do
    it 'returns new put token' do
      get :show, params: {id: 'image'}
      expect(response).to have_http_status(:success)
      expect(response.body).to be_truthy
    end
  end
end
