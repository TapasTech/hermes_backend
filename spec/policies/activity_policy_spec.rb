# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ActivityPolicy do
  subject { ActivityPolicy.new(user, the_user) }

  let(:activity) { create(:activity) }

  context 'for a visitor' do
  end

  context 'for a user' do
  end

  context 'for other user' do
  end
end
