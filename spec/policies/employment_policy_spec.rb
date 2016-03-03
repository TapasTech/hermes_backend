# frozen_string_literal: true
require 'rails_helper'

RSpec.describe EmploymentPolicy do
  subject { EmploymentPolicy.new(user, employment) }

  let(:employment) { create(:employment) }

  context 'for a visitor' do
    let(:user) { nil }

    it { should_not permit(:update) }
  end

  context 'for the owner' do
    let(:user) { employment.user }

    it { should permit(:update) }
  end

  context 'for another user' do
    let(:user) { create(:user) }

    it { should_not permit(:update) }
  end
end
