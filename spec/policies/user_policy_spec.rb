# frozen_string_literal: true
require 'rails_helper'

RSpec.describe UserPolicy do
  subject { UserPolicy.new(user, the_user) }

  let(:the_user) { create(:user) }

  context 'for a visitor' do
    let(:user) { nil }

    it { should permit(:create)       }
    it { should_not permit(:follow)   }
    it { should_not permit(:unfollow) }
  end

  context 'for a user' do
    let(:user) { the_user }

    it { should permit(:create)     }
    it { should_not permit(:follow) }
    it { should permit(:unfollow)   }
  end

  context 'for other user' do
    let(:user) { create(:user) }

    it { should permit(:create)   }
    it { should permit(:follow)   }
    it { should permit(:unfollow) }
  end
end
