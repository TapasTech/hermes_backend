# frozen_string_literal: true
module FollowableTypeMixin
  def self.apply(define)
    define.instance_exec(&FollowableMixin)
  end

  FollowableMixin =
    lambda do
      field :followers, field: PaginateField.create(User, property: :followers)
      field :followersCount, types.Int, 'Follower count', property: :followers_count
      field :followed, types.Boolean, 'Is followed by current user' do
        resolve lambda { |object, arguments, context|
          GraphQLAuthenticator.execute(object, arguments, context) do
            object.followed_by?(current_user)
          end
        }
      end
    end
end
