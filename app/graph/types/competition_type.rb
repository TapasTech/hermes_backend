# frozen_string_literal: true
CompetitionType = GraphQL::MutableType.define do
  name 'Competition'
  description 'Competition'

  BaseModelTypeMixin.apply(self)

  field :competitionType, -> { CompetitionTypeEnum }, 'Competition type' do
    resolve -> (object, _arguments, _context) { object.competition_type&.to_s }
  end
  field :title, types.String, 'Title'
  field :summary, types.String, 'Summary'
  field :description, types.String, 'Description'
  field :thumbLogoURL, types.String, 'Thumb logo URL', property: :thumb_logo_url
  field :logoURL, types.String, 'Logo', property: :logo_url
  field :startAt, -> { DateType }, 'Start datetime', property: :start_at
  field :expireAt, -> { DateType }, 'Expire datetime', property: :expire_at
  field :award, types.Float, 'Award'

  field :dataSet, -> { DataSetType }, 'Attachment data sets', property: :data_set
  field :fileUploadeds, -> { types[FileUploadedType] }, 'Attachment data set files', property: :file_uploadeds
  field :solutions, -> { types[SolutionType] }, 'Solutions'

  mutation do
    field :createSolution, field: SolutionsMutation::CreateSolutionField
  end
end
