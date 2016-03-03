# frozen_string_literal: true
require 'rails_helper'

RSpec.describe DataReportPolicy do
  subject { DataReportPolicy.new(user, data_report) }

  let(:data_report) { create(:data_report) }

  context 'for a visitor' do
    let(:user) { nil }

    it { should_not permit(:create) }
    it { should_not permit(:update) }
  end

  context 'for the owner' do
    let(:user) { data_report.user }

    it { should permit(:create) }
    it { should permit(:update) }
  end

  context 'for another user' do
    let(:user) { create(:user) }

    it { should permit(:create)     }
    it { should_not permit(:update) }
  end
end
