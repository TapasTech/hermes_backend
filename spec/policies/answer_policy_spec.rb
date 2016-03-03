# frozen_string_literal: true
require 'rails_helper'

RSpec.describe AnswerPolicy do
  subject { AnswerPolicy.new(user, answer) }

  let(:answer) { create(:answer) }

  context 'for a visitor' do
    let(:user) { nil }

    it { should_not permit(:create)             }
    it { should_not permit(:update)             }
    it { should_not permit(:add_data_set)       }
    it { should_not permit(:remove_data_set)    }
    it { should_not permit(:add_data_report)    }
    it { should_not permit(:remove_data_report) }
    it { should_not permit(:vote_up)            }
    it { should_not permit(:vote_down)          }
  end

  context 'for the owner' do
    let(:user) { answer.user }

    it { should permit(:create)             }
    it { should permit(:update)             }
    it { should permit(:add_data_set)       }
    it { should permit(:remove_data_set)    }
    it { should permit(:add_data_report)    }
    it { should permit(:remove_data_report) }
    it { should permit(:vote_up)            }
    it { should permit(:vote_down)          }
  end

  context 'for another user' do
    let(:user) { create(:user) }

    it { should permit(:create)                 }
    it { should_not permit(:update)             }
    it { should_not permit(:add_data_set)       }
    it { should_not permit(:remove_data_set)    }
    it { should_not permit(:add_data_report)    }
    it { should_not permit(:remove_data_report) }
    it { should permit(:vote_up)                }
    it { should permit(:vote_down)              }
  end
end
