MutationType = GraphQL::ObjectType.define do
  name 'Mutation'
  description 'Mutation Root'

  # Add your mutations here
  # field :createUser, field: FetchField.create(User)

  # Put your mutations under: mutations/
  # Define your mutation specific types under: mutation_types/
end
