# frozen_string_literal: true
module UserActions
  extend ActiveSupport::Concern
  included do
    include CommunityActions
    include SocialNetworkActions
    include CompetitionActions
  end
end
