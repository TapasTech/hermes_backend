# frozen_string_literal: true
class FileUploaded < ApplicationRecord
  belongs_to :uploadable, polymorphic: true
end
