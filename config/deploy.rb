# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

server 'ec2-18-218-149-45.us-east-2.compute.amazonaws.com', port: 22, roles: [:web, :app, :db], primary: true

#server 'localhost', roles: [:web, :app, :db], primary: false

#set :deploy_to, "/mnt/c/Users/#{fetch(:user)}/beetrack/"

set :repo_url, 'git@github.com:ignotummisterrii/test.git'

set :application, 'test'
set :user, 'ubuntu'
set :deploy_to, "/home/#{fetch(:user)}/#{fetch(:application)}/"


set :puma_threads,    [4, 16]
set :puma_workers,    0

set :pty,             false
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache

set :puma_bind,       "unix://#{fetch(:deploy_to)}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "/var/tmp/pids/puma.state"
set :puma_pid,        "/var/tmp/pids/puma.pid"
set :puma_access_log, "/var/log/puma.error.log"
set :puma_error_log,  "/var/log/puma.access.log"


set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord


namespace :puma do
  desc 'Create Directories for Puma Pids and Socket' 

  task :make_dirs do
    on roles(:app) do
      execute "mkdir /var/tmp/sockets -p"
      execute "mkdir /var/tmp/pids -p"
    end
  end

	before :start, :make_dirs
end


namespace :deploy do
  
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end


  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end


  #before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart

end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma