# frozen_string_literal: true
require 'rails_helper'

RSpec.describe QuestionPolicy do
  subject { QuestionPolicy.new(user, question) }

  let(:question) { create(:question) }

  context 'for a visitor' do
    let(:user) { nil }

    it { should_not permit(:create)             }
    it { should_not permit(:update)             }
    it { should_not permit(:add_topic)          }
    it { should_not permit(:remove_topic)       }
    it { should_not permit(:add_data_set)       }
    it { should_not permit(:remove_data_set)    }
    it { should_not permit(:add_data_report)    }
    it { should_not permit(:remove_data_report) }
    it { should_not permit(:vote_up)            }
    it { should_not permit(:vote_down)          }
    it { should_not permit(:follow)             }
    it { should_not permit(:unfollow)           }
  end

  context 'for the owner' do
    let(:user) { question.user }

    it { should permit(:create)             }
    it { should permit(:update)             }
    it { should permit(:add_topic)          }
    it { should permit(:remove_topic)       }
    it { should permit(:add_data_set)       }
    it { should permit(:remove_data_set)    }
    it { should permit(:add_data_report)    }
    it { should permit(:remove_data_report) }
    it { should permit(:vote_up)            }
    it { should permit(:vote_down)          }
    it { should permit(:follow)             }
    it { should permit(:unfollow)           }
  end

  context 'for another user' do
    let(:user) { create(:user) }

    it { should permit(:create)                 }
    it { should_not permit(:update)             }
    it { should permit(:add_topic)              }
    it { should_not permit(:remove_topic)       }
    it { should permit(:add_data_set)           }
    it { should_not permit(:remove_data_set)    }
    it { should permit(:add_data_report)        }
    it { should_not permit(:remove_data_report) }
    it { should permit(:vote_up)                }
    it { should permit(:vote_down)              }
    it { should permit(:follow)                 }
    it { should permit(:unfollow)               }
  end
end
