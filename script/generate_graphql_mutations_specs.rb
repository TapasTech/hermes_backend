# frozen_string_literal: true
FILE_PATHS = Dir['./app/graph/mutations/*_mutation.rb']
MUTATION_SPECS_BASE = Rails.root.join('spec', 'graph', 'mutations')

template = lambda do |mutation_name, model_name, field_codes|
  "# frozen_string_literal: true
require 'rails_helper'

RSpec.describe #{mutation_name} do
  subject { described_class }
  let(:#{model_name}) { create(:#{model_name}) }

#{field_codes}
end
"
end

field_template = lambda do |mutation_name, model_name, field_name|
  "  describe '::#{field_name}' do
    let(:resolution) do
      ::#{mutation_name}::#{field_name}.resolve(
        #{model_name},
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {}
      end

      let(:current_user) { user }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
      end
    end
  end"
end

def extract_model_name(mutation)
  mutation.name.gsub(/Mutation\Z/, '').underscore.singularize
end

def find_fields(mutation)
  mutation.constants.map(&:to_s).select { |const| const =~ /Field\Z/ }
end

FILE_PATHS.each do |file_path|
  path = Pathname.new(file_path)
  file_name = path.basename(path.extname).to_s
  spec_path = MUTATION_SPECS_BASE.join("#{file_name}_spec.rb")
  mutation = file_name.camelize.constantize
  model_name = extract_model_name(mutation)

  next if spec_path.exist?
  fields = find_fields(mutation).map { |f| field_template[mutation.name, model_name, f] }
  text = template[mutation.name, model_name, fields.join("\n\n")]

  File.open(spec_path, 'w') do |file|
    file.puts text
  end
end
