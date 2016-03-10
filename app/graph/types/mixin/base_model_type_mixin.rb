# frozen_string_literal: true
module BaseModelTypeMixin
  def self.apply(define, paranoia: true)
    define.instance_exec do
      field :id, !types.ID, 'ID'
      field :createdAt, -> { DateType }, 'Create datetime', property: :created_at
      field :updatedAt, -> { DateType }, 'Update datetime', property: :updated_at
      field :deletedAt, -> { DateType }, 'Detele datetime', property: :deleted_at if paranoia
    end
  end
end
