# frozen_string_literal: true
UserType = GraphQL::MutableType.define do
  name 'User'
  description 'User'

  field :id, !types.ID
  field :createdAt, -> { DateType }, property: :created_at
  field :updatedAt, -> { DateType }, property: :updated_at
  field :deletedAt, -> { DateType }, property: :deleted_at

  field :email, types.String
  field :display_name, types.String
  field :gender, types.String

  field :business, -> { BusinessType }
  field :location, -> { LocationType }
  field :employment, -> { EmploymentType }
  field :education, -> { EducationType }

  field :followers, field: PaginateField.create(User, property: :followers)
  field :followees, field: PaginateField.create(User, property: :followees)
  field :followersCount, types.Int, property: :followers_count
  field :followeesCount, types.Int, property: :followees_count

  field :questions, field: PaginateField.create(Question, property: :questions)
  field :answers, field: PaginateField.create(Answer, property: :answers)
  field :comments, field: PaginateField.create(Comment, property: :comments)
  field :replyComments, field: PaginateField.create(Comment, property: :reply_comments)
  field :questionsCount, types.Int, property: :questions_count
  field :answersCount, types.Int, property: :answers_count

  field :activities, field: PaginateField.create(Activity, property: :activities,
                                                           transform: ->(a) { a.order(created_at: :desc) })

  mutation do
    field :update, field: UsersMutation::UpdateUserField

    field :follow, field: UsersMutation::FollowField
    field :unfollow, field: UsersMutation::UnfollowField
  end
end
