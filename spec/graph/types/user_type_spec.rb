# frozen_string_literal: true
require 'rails_helper'

RSpec.describe UserType, type: :model do
  let(:fields) { UserType.fields }
  let(:expected_fields) do
    %w(
      id
      createdAt
      updatedAt
      deletedAt
      email
      displayName
      gender
      business
      location
      employment
      education
      followers
      followees
      followersCount
      followeesCount
      questions
      answers
      comments
      replyComments
      questionsCount
      answersCount
      activities
      mutation
    )
  end

  describe 'fields' do
    it 'are expected_fields' do
      expect(fields.keys).to eq(expected_fields)
    end
  end
end
