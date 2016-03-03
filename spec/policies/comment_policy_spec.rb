# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CommentPolicy do
  subject { CommentPolicy.new(user, comment) }

  let(:comment) { create(:comment) }

  context 'for a visitor' do
    let(:user) { nil }

    it { should_not permit(:create)    }
    it { should_not permit(:vote_up)   }
    it { should_not permit(:vote_down) }
  end

  context 'for a user' do
    let(:user) { comment.user }

    it { should permit(:create)    }
    it { should permit(:vote_up)   }
    it { should permit(:vote_down) }
  end

  context 'for other user' do
    let(:user) { create(:user) }

    it { should permit(:create)    }
    it { should permit(:vote_up)   }
    it { should permit(:vote_down) }
  end
end
