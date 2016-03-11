# frozen_string_literal: true
module DatableTypeMixin
  def self.apply(define)
    define.instance_exec do
      field :dataSets, field: PaginateField.create(DataSet, property: :data_sets)
      field :dataReports, field: PaginateField.create(DataReport, property: :data_reports)
    end
  end
end
