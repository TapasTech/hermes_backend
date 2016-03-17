# frozen_string_literal: true
FileUploadedType = GraphQL::MutableType.define do
  name 'FileUploaded'
  description 'File Uploaded'

  BaseModelTypeMixin.apply(self)

  field :name, types.String, 'Name'
  field :size, types.Int, 'Size'
  field :description, types.String, 'Description'
  field :format, types.String, 'Format'
  field :url, types.String, 'URL'
end
