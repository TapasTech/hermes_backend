# frozen_string_literal: true
QuestionType = GraphQL::MutableType.define do
  name 'Question'
  description 'Question'

  field :id, !types.ID, 'ID'
  field :createdAt, -> { DateType }, 'Create datetime', property: :created_at
  field :updatedAt, -> { DateType }, 'Update datetime', property: :updated_at
  field :deletedAt, -> { DateType }, 'Detele datetime', property: :deleted_at

  field :user, -> { UserType }, 'Questioner'
  field :title, types.String, 'Title'
  field :content, types.String, 'Content'
  field :topics, -> { types[TopicType] }, 'Related topics'

  field :readCount, types.Int, 'Read count', property: :read_count

  field :dataSets, field: PaginateField.create(DataSet, property: :data_sets)
  field :dataReports, field: PaginateField.create(DataReport, property: :data_reports)
  field :answers, field: PaginateField.create(Answer, property: :answers,
                                                      transform: ->(a) { a.order(confidence: :desc) })
  field :answersCount, types.Int, property: :answers_count

  field :upVotesCount, types.Int, property: :up_votes_count
  field :downVotesCount, types.Int, property: :down_votes_count
  field :totalVotesCount, types.Int, property: :total_votes_count

  field :followers, field: PaginateField.create(User, property: :followers)
  field :followersCount, types.Int, property: :followers_count
  field :followed, types.Boolean do
    resolve lambda { |object, arguments, context|
      GraphQLAuthenticator.execute(object, arguments, context) do
        object.followed_by?(current_user)
      end
    }
  end

  mutation do
    field :update, field: QuestionsMutation::UpdateQuestionField

    field :addTopic, field: QuestionsMutation::AddTopicField
    field :removeTopic, field: QuestionsMutation::RemoveTopicField

    field :addDataSet, field: QuestionsMutation::AddDataSetField
    field :removeDataSet, field: QuestionsMutation::RemoveDataSetField

    field :addDataReport, field: QuestionsMutation::AddDataReportField
    field :removeDataReport, field: QuestionsMutation::RemoveDataReportField

    field :voteUp, field: QuestionsMutation::VoteUpField
    field :voteDown, field: QuestionsMutation::VoteDownField

    field :follow, field: QuestionsMutation::FollowField
    field :unfollow, field: QuestionsMutation::UnfollowField

    field :createAnswer, field: AnswersMutation::CreateAnswerField
  end
end
