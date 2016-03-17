# frozen_string_literal: true
require 'rails_helper'

RSpec.describe FileUploadedsMutation do
  subject { described_class }

  let(:solution) { create(:solution) }

  describe '::CreateAnswerField' do
    let(:resolution) do
      ::FileUploadedsMutation::CreateFileUploadedField.resolve(
        solution,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }
    let(:file_argument) { build(:file_uploaded) }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          name: file_argument.name,
          size: file_argument.size,
          description: file_argument.description,
          format: file_argument.format,
          url: file_argument.url
        }
      end

      let(:current_user) { create(:user) }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution).to have_attributes(
          description: arguments[:description],
          name: arguments[:name],
          url: arguments[:url]
        )
        expect(resolution.uploadable).to eq(solution)
      end
    end
  end
end
