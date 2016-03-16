# frozen_string_literal: true
module FileUploadedsMutation
  AttachFileField = GraphQL::Field.define do
    type -> { FileUploadedType }

    argument :name, !types.String, 'Name'
    argument :size, !types.Int, 'Size in bytes'
    argument :description, types.String, 'Description'
    argument :format, !types.String, 'Format'
    argument :url, !types.String, 'URL'

    resolve ->(*p) { FileUploadedsMutation.create(*p) }
  end

  # Methods that resolves
  module ResolverMethods
    def create(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize(current_user, FileUploaded, :create?)

        build_arguments =
            GraphQLArgumentProcessor.camel_keys_to_underscore arguments
        build_arguments[:uploadable] = object
        FileUploaded.create!(build_arguments)
      end
    end
  end

  extend ResolverMethods
end