# frozen_string_literal: true
require 'rails_helper'

RSpec.describe EducationPolicy do
  subject { EducationPolicy.new(user, education) }

  let(:education) { create(:education) }

  context 'for a visitor' do
    let(:user) { nil }

    it { should_not permit(:update) }
  end

  context 'for the owner' do
    let(:user) { education.user }

    it { should permit(:update) }
  end

  context 'for another user' do
    let(:user) { create(:user) }

    it { should_not permit(:update) }
  end
end
