# frozen_string_literal: true
require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/multistage'
require 'mina/rbenv' # for rbenv support. (http://rbenv.org)

set :shared_paths, [
  'config/database.yml',
  'config/secrets.yml',
  "config/settings/#{rails_env}.yml",
  'log', 'tmp']

task :environment do
  invoke :'rbenv:load'
end

task setup: :environment do
  queue! %(mkdir -p "#{deploy_to}/#{shared_path}/log")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log")

  queue! %(mkdir -p "#{deploy_to}/#{shared_path}/tmp")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp")

  queue! %(mkdir -p "#{deploy_to}/#{shared_path}/config")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config")
  queue! %(mkdir -p "#{deploy_to}/#{shared_path}/config/settings")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config/settings")

  queue! %(touch "#{deploy_to}/#{shared_path}/config/database.yml")
  queue! %(touch "#{deploy_to}/#{shared_path}/config/secrets.yml")
  queue! %(touch "#{deploy_to}/#{shared_path}/config/settings/#{rails_env}.yml")
  queue  %(echo "-----> Be sure to edit files under '#{deploy_to}/#{shared_path}/config'.")

  if repository
    repo_host = repository.split(%r{@|://}).last.split(%r{:|\/}).first
    repo_port = /:([0-9]+)/.match(repository) && /:([0-9]+)/.match(repository)[1] || '22'

    queue %(
      if ! ssh-keygen -H  -F #{repo_host} &>/dev/null; then
        ssh-keyscan -t rsa -p #{repo_port} -H #{repo_host} >> ~/.ssh/known_hosts
      fi
    )
  end
end

desc 'Deploys the current version to the server.'
task deploy: :environment do
  to :before_hook do
    # Put things to run locally before ssh
  end
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    queue "cp #{deploy_to}/public ./public"
    invoke :'deploy:cleanup'

    to :launch do
      queue "mkdir -p #{deploy_to}/#{current_path}/tmp/"
      queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt"

      queue! "kill -9 `cat tmp/pids/server.pid`; #{rails} server -b 0.0.0.0 -p #{rails_port} -d"
    end
  end
end

task l: :log
task c: :console
