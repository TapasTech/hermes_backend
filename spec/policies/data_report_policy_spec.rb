# frozen_string_literal: true
require 'rails_helper'

RSpec.describe DataReportPolicy do
  subject { DataReportPolicy.new(user, data_report) }

  let(:data_report) { create(:data_report) }

  context 'for a visitor' do
    let(:user) { nil }

    it { should_not permit(:create) }
  end

  context 'for any user' do
    let(:user) { create(:user) }

    it { should permit(:create) }
  end
end
