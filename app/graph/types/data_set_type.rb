# frozen_string_literal: true
DataSetType = GraphQL::MutableType.define do
  name 'DataSet'
  description 'Data Set'

  BaseModelTypeMixin.apply(self)

  field :user, -> { UserType }, 'Uploader'
  field :title, types.String, 'Title'
  field :url, types.String, 'Link'

  field :questions, field: PaginateField.create(Question, property: :questions)
  field :answers, field: PaginateField.create(Answer, property: :answers)
  field :competition, -> { CompetitionType }, 'Competition'

  field :fileUploadeds, -> { types[FileUploadedType] }, 'Attachment files', property: :file_uploadeds

  mutation do
    field :update, field: DataSetsMutation::UpdateDataSetField
  end
end
