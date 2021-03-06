# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"




require 'capistrano-db-tasks'

#FIXME add your app name here
set :application, "AdminFour"
#FIXME replace 'git@github.com:YOUR-GIT-REPO-HERE' with your git clone url
set :repo_url, 'git@github.com:Vedoc/AdminFour.git'
#FIXME add location on the server here
set :deploy_to, '/home/deploy/AdminFour'
set :branch, ENV['BRANCH'] if ENV['BRANCH']

set :linked_files, %w{config/database.yml config/master.key}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
#set :rvm_type, :user
set :rvm_map_bins, %w{gem rake ruby rails bundle}
set :rvm_type, :user                     # Defaults to: :auto
set :rvm_ruby_version, '3.0.0'      # Defaults to: 'default'
set :rvm_custom_path, "/usr/share/rvm"
#set :default_env, { rvm_bin_path: '~/.rvm/bin' }

set :keep_releases, 3
set :keep_assets, 3

set :db_local_clean, true
set :db_remote_clean, true

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end
