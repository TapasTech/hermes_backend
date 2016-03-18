# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CompetitionPolicy do
  subject { CompetitionPolicy.new(user, competition) }

  let(:competition) { create(:competition) }

  context 'for a visitor' do
    let(:user) { nil }
  end

  context 'for a user' do
    let(:user) { create(:user) }
  end
end
