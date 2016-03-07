# frozen_string_literal: true
require 'rails_helper'

RSpec.describe GraphQLController, type: :controller do
  describe 'GET introspection' do
    let(:graphql_introspection) { MultiJson.dump ApplicationSchema.execute(GraphQL::Introspection::INTROSPECTION_QUERY) }
    it 'returns http success' do
      get :introspection
      expect(response).to have_http_status(:success)
      expect(response.body).to eq(graphql_introspection)
    end
  end

  describe 'POST query' do
    it 'returns http success' do
      post :query, params: {query: GraphQL::Introspection::INTROSPECTION_QUERY}
      expect(response).to have_http_status(:success)
    end
  end
end
