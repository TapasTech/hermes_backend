# frozen_string_literal: true
file = '/Users/Karloku/Workspace/Tapas/_Documents/Hermes/1.yml'

def load_competitions!(file)
  competitions = YAML.load(open(file).read)

  competitions['Competitions'].each do |competition|
    create_competition!(competition)
  end
end

def create_competition!(competition)
  prepare_data_set!(competition)
  Competition.create(competition)
end

def prepare_data_set!(competition)
  data_set = competition['data_set']
  prepare_file_uploadeds!(data_set)
  data_set['url'] = 'FILES'
  competition['data_set'] = DataSet.create!(data_set)
end

def prepare_file_uploadeds!(data_set)
  file_uploadeds = data_set['file_uploadeds']
  data_set['file_uploadeds'] = file_uploadeds.map do |file_uploaded|
    FileUploaded.create!(file_uploaded)
  end
end

load_competitions!(file)
