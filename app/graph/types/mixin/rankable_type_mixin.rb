# frozen_string_literal: true
module RankableTypeMixin
  def self.apply(define)
    define.instance_exec(&VoteCountsMixin)
    define.instance_exec(&VoteCheckMixin)
  end

  VoteCountsMixin =
    lambda do
      field :upVotesCount, types.Int, 'Up vote count', property: :up_votes_count
      field :downVotesCount, types.Int, 'Down vote count', property: :down_votes_count
      field :totalVotesCount, types.Int, 'Total vote count', property: :total_votes_count
    end

  VoteCheckMixin =
    lambda do
      field :votedUp, types.Boolean, 'Is voted up by curnent user' do
        resolve lambda { |object, arguments, context|
          GraphQLAuthenticator.execute(object, arguments, context) do
            object.up_vote_by?(current_user)
          end
        }
      end

      field :votedDown, types.Boolean, 'Is voted down by curnent user' do
        resolve lambda { |object, arguments, context|
          GraphQLAuthenticator.execute(object, arguments, context) do
            object.down_vote_by?(current_user)
          end
        }
      end
    end
end
