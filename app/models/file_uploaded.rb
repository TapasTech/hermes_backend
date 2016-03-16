# frozen_string_literal: true
class FileUploaded < ApplicationRecord
  acts_as_paranoid

  belongs_to :uploadable, polymorphic: true
end
