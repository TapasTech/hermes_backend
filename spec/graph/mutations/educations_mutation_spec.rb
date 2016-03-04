# frozen_string_literal: true
require 'rails_helper'

RSpec.describe EducationsMutation do
  subject { described_class }
  let(:education) { create(:education) }

  describe '::UpdateEducationField' do
    let(:resolution) do
      ::EducationsMutation::UpdateEducationField.resolve(
        education,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          organization: '一所好学校',
          direction: '一个好方向'
        }
      end

      let(:current_user) { education.user }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution).to have_attributes(
          organization: arguments[:organization],
          direction: arguments[:direction])
      end
    end
  end
end
