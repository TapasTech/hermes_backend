module GraphQLTypeFinder
  # Module Methods
  module ModuleMethods
    def find_by_name(name)
      types.detect { |type| name == type.name }
    end

    def types
      ObjectSpace.each_object(GraphQL::BaseType)
    end
  end

  extend ModuleMethods
end
