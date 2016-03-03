# frozen_string_literal: true
# Fetch paginated list
class PaginateField
  def self.create(model, property: nil, transform: nil)
    GraphQL::Field.define do
      type PaginateField.paginated_type(model)

      argument :page,  types.Int
      argument :count, types.Int

      resolve PaginateField.resolver(model, property: property, transform: transform)
    end
  end

  def self.resolver(model, property: nil, transform: nil)
    lambda do |object, arguments, context|
      GraphQLAuthenticator.execute(object, arguments, context) do
        records =
          property.present? ? object.public_send(property) : model

        records = GraphQLAuthorizer.policy_scope current_user, records.page(arguments[:page]).per(arguments[:count])
        return records unless transform.present?
        transform.call(records)
      end
    end
  end

  def self.paginated_type(model)
    type = GraphQLTypeFinder.find_by_name(paginated_type_name(model))
    return type if type.present?

    define_type(model)
  end

  def self.paginated_type_name(model)
    "Paginated#{model.name}"
  end

  def self.define_type(model)
    PaginateField::PaginateType[model]
  end

  PaginateType = lambda do |model|
    GraphQL::ObjectType.define do
      paginated_type_name = PaginateField.paginated_type_name(model)

      name paginated_type_name
      description paginated_type_name.titleize

      field :data, -> { types["#{model.name}Type".constantize] } do
        resolve -> (object, _, _) { object }
      end

      field :meta, -> { PaginateField::MetaType } do
        resolve -> (object, _, _) { object }
      end
    end
  end

  MetaType = GraphQL::ObjectType.define do
    name 'PaginationMeta'
    description 'Pagination Meta'

    field :current_page, types.Int
    field :total_pages,  types.Int
    field :total_count,  types.Int
  end
end
