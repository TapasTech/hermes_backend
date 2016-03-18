# frozen_string_literal: true
require 'rails_helper'

RSpec.describe SolutionPolicy do
  subject { SolutionPolicy.new(user, solution) }

  let(:solution) { create(:solution) }

  context 'for a visitor' do
    let(:user) { nil }

    it { should_not permit(:create) }
  end

  context 'for a user' do
    let(:user) { create(:user) }

    it { should permit(:create) }
  end
end
