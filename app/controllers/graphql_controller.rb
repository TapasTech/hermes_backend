# frozen_string_literal: true
class GraphQLController < ApplicationController
  def introspection
    ApplicationSchema.execute GraphQL::Introspection::INTROSPECTION_QUERY
  end
  
  def query
    ApplicationSchema.execute(params[:query], context: {current_user: current_user})
  end
end
