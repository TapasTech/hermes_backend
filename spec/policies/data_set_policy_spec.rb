# frozen_string_literal: true
require 'rails_helper'

RSpec.describe DataSetPolicy do
  subject { DataSetPolicy.new(user, data_set) }

  let(:data_set) { create(:data_set) }

  context 'for a visitor' do
    let(:user) { nil }

    it { should_not permit(:create) }
    it { should_not permit(:update) }
  end

  context 'for the owner' do
    let(:user) { data_set.user }

    it { should permit(:create) }
    it { should permit(:update) }
  end

  context 'for another user' do
    let(:user) { create(:user) }

    it { should permit(:create)     }
    it { should_not permit(:update) }
  end
end
