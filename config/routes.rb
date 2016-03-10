# frozen_string_literal: true
Rails.application.routes.draw do
  get  'graphql', to: 'graphql#introspection'
  post 'graphql', to: 'graphql#query'
  get '_puttoken', to: 'put_tokens#create'
  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
