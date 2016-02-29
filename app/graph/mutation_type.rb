# frozen_string_literal: true
MutationType = GraphQL::ObjectType.define do
  name 'Mutation'
  description 'Mutation Root'

  # user
  field :createUser, field: UsersMutation::CreateUserField
  field :createAuthToken, field: AuthTokensMutation::CreateAuthTokenField
  field :renewAuthToken, field: AuthTokensMutation::RenewAuthTokenField

  # question
  field :createQuestion, field: QuestionsMutation::CreateQuestionField
end
