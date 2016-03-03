# frozen_string_literal: true
class GraphQLController < ApplicationController
  def introspection
    render json: ApplicationSchema.execute(GraphQL::Introspection::INTROSPECTION_QUERY),
           status: :ok
  end

  def query
    render json: ApplicationSchema.execute(params[:query], context: {current_user: current_user}),
           status: :ok
  end
end
