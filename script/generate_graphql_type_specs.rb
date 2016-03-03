# frozen_string_literal: true
FILE_PATHS = Dir['./app/graph/types/*_type.rb']
TYPE_SPECS_BASE = Rails.root.join('spec', 'graph', 'types')

template = lambda do |type_name|
"# frozen_string_literal: true
require 'rails_helper'

RSpec.describe #{type_name}, type: :model do
  let(:fields) { described_class.fields }
  let(:mutation_fields) { fields['mutation']&.type&.fields }
  let(:expected_fields) do
    %w(
    )
  end

  let(:expected_mutation_fields) do
    %w(
    )
  end

  describe 'fields' do
    it 'are expected_fields' do
      expect(fields.keys).to contain_exactly(*expected_fields)
      expect(mutation_fields&.keys || []).to contain_exactly(*expected_mutation_fields)
    end
  end
end
"
end

FILE_PATHS.each do |file_path|
  path = Pathname.new(file_path)
  file_name = path.basename(path.extname).to_s
  spec_path = TYPE_SPECS_BASE.join("#{file_name}_spec.rb")
  type_name = file_name.camelize
  unless spec_path.exist?
    File.open(spec_path, 'w') do |file|
      file.puts template[type_name]
    end
  end
end
