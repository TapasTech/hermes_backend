# frozen_string_literal: true
SolutionType = GraphQL::MutableType.define do
  name 'Solution'
  description 'Solution'

  BaseModelTypeMixin.apply(self)

  field :user, -> { UserType }, 'Uploader'
  field :competition, -> { CompetitionType }, 'Competition'
  field :description, types.String, 'Description'
  field :fileUploadeds, -> { types[FileUploadedType] }, 'Attachment solution files',
        property: :file_uploadeds

  mutation do
    field :attachFile, field: FileUploadedsMutation::CreateFileUploadedField
  end
end
