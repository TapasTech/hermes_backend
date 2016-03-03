# frozen_string_literal: true
require 'rails_helper'

RSpec.describe DataSetPolicy do
  subject { DataSetPolicy.new(user, data_set) }

  let(:data_set) { create(:data_set) }

  context 'for a visitor' do
    let(:user) { nil }

    it { should_not permit(:create) }
  end

  context 'for any user' do
    let(:user) { create(:user) }

    it { should permit(:create) }
  end
end
