# frozen_string_literal: true
class GraphQLController < ApplicationController
  def query
    ApplicationSchema.execute(params[:query], context: {current_user: current_user})
  end
end
