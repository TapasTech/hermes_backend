# frozen_string_literal: true
require 'rails_helper'

RSpec.describe TopicPolicy do
  subject { TopicPolicy.new(user, the_user) }

  let(:topic) { create(:topic) }

  context 'for a visitor' do
  end

  context 'for a user' do
  end

  context 'for other user' do
  end
end
