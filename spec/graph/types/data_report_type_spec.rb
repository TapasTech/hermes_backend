# frozen_string_literal: true
require 'rails_helper'

RSpec.describe DataReportType do
  let(:fields) { described_class.fields }
  let(:mutation_fields) { fields['mutation']&.type&.fields }
  let(:expected_fields) do
    %w(
      id
      createdAt
      updatedAt
      deletedAt
      user
      title
      url
      questions
      answers
      mutation
    )
  end

  let(:expected_mutation_fields) do
    %w(
      update
    )
  end

  describe 'fields' do
    it 'are expected_fields' do
      expect(fields.keys).to contain_exactly(*expected_fields)
      expect(mutation_fields&.keys || []).to contain_exactly(*expected_mutation_fields)
    end
  end
end
