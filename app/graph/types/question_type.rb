# frozen_string_literal: true
QuestionType = GraphQL::MutableType.define do
  name 'Question'
  description 'Question'

  BaseModelTypeMixin.apply(self)
  DatableTypeMixin.apply(self)
  RankableTypeMixin.apply(self)

  field :editedAt, -> { DateType }, 'Edit datetime', property: :edited_at
  field :user, -> { UserType }, 'Questioner'
  field :title, types.String, 'Title'
  field :content, types.String, 'Content'
  field :topics, -> { types[TopicType] }, 'Related topics'

  field :readCount, types.Int, 'Read count' do
    resolve -> (object, _arguments, _context) { object.read_count.value }
  end

  field :answers, field: PaginateField.create(Answer, property: :answers,
                                                      transform: ->(a) { a.order('confidence DESC NULLS LAST') })
  field :answersCount, types.Int, 'Answer count', property: :answers_count

  FollowableTypeMixin.apply(self)

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

    field :read, field: QuestionsMutation::ReadField
  end
end
