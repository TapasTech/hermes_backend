# frozen_string_literal: true
UserType = GraphQL::MutableType.define do
  name 'User'
  description 'User'

  field :id, !types.ID, 'ID'
  field :createdAt, -> { DateType }, 'Create datetime', property: :created_at
  field :updatedAt, -> { DateType }, 'Update datetime', property: :updated_at
  field :deletedAt, -> { DateType }, 'Detele datetime', property: :deleted_at

  field :email, types.String, 'E-mail'
  field :displayName, types.String, 'Display name', property: :display_name
  field :description, types.String, 'Description'
  field :gender, types.String, 'Gender'

  field :business, -> { BusinessType }, 'Business'
  field :location, -> { LocationType }, 'Location'
  field :employment, -> { EmploymentType }, 'Employment'
  field :education, -> { EducationType }, 'Education'

  field :followers, field: PaginateField.create(User, property: :followers)
  field :followees, field: PaginateField.create(User, property: :followees)
  field :followersCount, types.Int, 'Follower count', property: :followers_count
  field :followeesCount, types.Int, 'Followee count', property: :followees_count

  field :questions, field: PaginateField.create(Question, property: :questions)
  field :answers, field: PaginateField.create(Answer, property: :answers)
  field :comments, field: PaginateField.create(Comment, property: :comments)
  field :replyComments, field: PaginateField.create(Comment, property: :reply_comments)
  field :questionsCount, types.Int, 'Question count', property: :questions_count
  field :answersCount, types.Int, 'Answer count', property: :answers_count

  field :dataSets, field: PaginateField.create(DataSet, property: :data_sets)
  field :dataReports, field: PaginateField.create(DataReport, property: :data_reports)

  field :upVotesCount, types.Int, 'Up votes got through answers' do
    resolve ->(object, _arguments, _context) { object.up_votes_count.value }
  end
  field :downVotesCount, types.Int, 'Down votes got through answers' do
    resolve ->(object, _arguments, _context) { object.down_votes_count.value }
  end

  field :activities, field: PaginateField.create(Activity, property: :activities,
                                                           transform: ->(a) { a.order(created_at: :desc) })

  mutation do
    field :update, field: UsersMutation::UpdateUserField

    field :follow, field: UsersMutation::FollowField
    field :unfollow, field: UsersMutation::UnfollowField
  end
end
