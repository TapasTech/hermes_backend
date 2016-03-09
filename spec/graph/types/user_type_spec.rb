# frozen_string_literal: true
require 'rails_helper'

RSpec.describe UserType do
  let(:fields) { described_class.fields }
  let(:mutation_fields) { fields['mutation']&.type&.fields }
  let(:expected_fields) do
    %w(
      id
      createdAt
      updatedAt
      deletedAt
      email
      displayName
      description
      gender
      business
      location
      employment
      education
      followers
      followees
      followersCount
      followeesCount
      followed
      questions
      answers
      comments
      replyComments
      questionsCount
      answersCount
      goodAtTopics
      dataSets
      dataReports
      upVotesCount
      downVotesCount
      activities
      mutation
    )
  end

  let(:expected_mutation_fields) do
    %w(
      update
      follow
      unfollow
    )
  end

  describe 'fields' do
    it 'are expected_fields' do
      expect(fields.keys).to contain_exactly(*expected_fields)
      expect(mutation_fields&.keys || []).to contain_exactly(*expected_mutation_fields)
    end
  end

  describe '#followed' do
    let(:user) { create(:user) }
    let(:follower) { create(:user).tap { |u| u.follow(user) } }
    let(:unfollowing_user) { create(:user) }
    let(:context) { {current_user: current_user} }
    let(:resolution) { fields['followed'].resolve(user, {}, context) }

    context 'as a follower' do
      let(:current_user) { follower }

      it 'returns true' do
        expect(resolution).to be(true)
      end
    end

    context 'as an unfollowing user' do
      let(:current_user) { unfollowing_user }
      it 'returns false' do
        expect(resolution).to be(false)
      end
    end

    context 'as a visitor' do
      let(:current_user) { nil }

      it 'returns false' do
        expect(resolution).to be(false)
      end
    end
  end
end
