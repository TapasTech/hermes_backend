# frozen_string_literal: true
class GraphQLController < ApplicationController
  rescue_from GraphQL::ParseError, with: :bad_graphql_query

  def introspection
    render json: ApplicationSchema.execute(GraphQL::Introspection::INTROSPECTION_QUERY),
           status: :ok
  end

  def query
    render json: ApplicationSchema.execute(params[:query], context: {current_user: current_user}),
           status: :ok
  end

  protected
  def bad_graphql_query(exception)
    render json: {error: exception.message}, status: :bad_request
  end
end
