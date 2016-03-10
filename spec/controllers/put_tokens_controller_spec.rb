# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PutTokensController, type: :controller do
  describe 'GET post' do
    it 'returns new put token' do
      get :create
      expect(response).to have_http_status(:success)
      expect(response.body).to be_truthy
    end
  end
end
