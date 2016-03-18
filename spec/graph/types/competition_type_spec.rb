# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CompetitionType, type: :model do
  let(:fields) { described_class.fields }
  let(:mutation_fields) { fields['mutation']&.type&.fields }
  let(:expected_fields) do
    %w(
      id
      createdAt
      updatedAt
      deletedAt
      title
      summary
      description
      thumbLogoURL
      logoURL
      startAt
      expireAt
      award
      competitionType
      dataSet
      fileUploadeds
      solutions
      mutation
    )
  end

  let(:expected_mutation_fields) do
    %w(
      createSolution
    )
  end

  describe 'fields' do
    it 'are expected_fields' do
      expect(fields.keys).to contain_exactly(*expected_fields)
      expect(mutation_fields&.keys || []).to contain_exactly(*expected_mutation_fields)
    end
  end
end
