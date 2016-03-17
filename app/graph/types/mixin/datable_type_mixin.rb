# frozen_string_literal: true
module DatableTypeMixin
  def self.apply(define)
    define.instance_exec do
      field :dataSets, -> { types[DataSetType] }, 'Data sets', property: :data_sets
      # field: PaginateField.create(DataSet, property: :data_sets)
      field :dataReports, -> { types[DataReportType] }, 'Data report', property: :data_reports
      # field: PaginateField.create(DataReport, property: :data_reports)
    end
  end
end
