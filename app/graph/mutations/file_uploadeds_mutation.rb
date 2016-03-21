# frozen_string_literal: true
module FileUploadedsMutation
  CreateFileUploadedField = GraphQL::Field.define do
    type -> { FileUploadedType }

    argument :name, !types.String, 'Name'
    argument :size, !types.Int, 'Size in bytes'
    argument :description, types.String, 'Description'
    argument :format, !types.String, 'Format'
    argument :url, !types.String, 'URL'

    resolve ->(*p) { FileUploadedsMutation.create(*p) }
  end

  RemoveFileUploadedField = GraphQL::Field.define do
    type types.Boolean

    argument :id, !types.ID, 'Id'

    resolve ->(*p) { FileUploadedsMutation.remove(*p) }
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

    def remove(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        file_uploaded = object.file_uploadeds.find(arguments[:id])

        GraphQLAuthorizer.authorize(current_user, file_uploaded, :remove?)

        object.file_uploadeds.destroy(file_uploaded)

        true
      end
    end
  end

  extend ResolverMethods
end
