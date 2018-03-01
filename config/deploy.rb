# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

#server 'ec2-18-218-149-45.us-east-2.compute.amazonaws.com', port: 22, roles: [:web, :app, :db], primary: true

#server 'localhost', roles: [:web, :app, :db], primary: false

#set :deploy_to, "/mnt/c/Users/#{fetch(:user)}/beetrack/"

set :repo_url, 'git@github.com:ignotummisterrii/test.git'
set :application,     'test'
set :user,            'ubuntu'
set :puma_threads,    [4, 16]
set :puma_workers,    0


# Don't change these unless you know what you're doing
set :pty,             false
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"


puts "#{shared_path}"
puts "#{release_path}"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord



set :sidekiq_default_hooks => true
set :sidekiq_pid => File.join(shared_path, 'tmp', 'pids', 'sidekiq.pid') # ensure this path exists in production before deploying.
set :sidekiq_env => fetch(:rack_env, fetch(:rails_env, fetch(:stage)))
set :sidekiq_log => File.join(shared_path, 'log', 'sidekiq.log')
set :sidekiq_options => nil
set :sidekiq_require => nil
set :sidekiq_tag => nil
set :sidekiq_config => nil # if you have a config/sidekiq.yml, do not forget to set this. 
set :sidekiq_queue => nil
set :sidekiq_timeout => 10
set :sidekiq_roles => :app
set :sidekiq_processes => 1
set :sidekiq_options_per_process => nil
set :sidekiq_concurrency => nil

# sidekiq monit
set :sidekiq_monit_templates_path => 'config/deploy/templates'
set :sidekiq_monit_conf_dir => '/etc/monit/conf.d'
set :sidekiq_monit_use_sudo => true
set :monit_bin => '/usr/bin/monit'
set :sidekiq_monit_default_hooks => true
set :sidekiq_monit_group => nil





namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
      execute "mkdir #{shared_path}/log -p"
    end
  end

  task :services do
    on roles(:app) do
      execute "redis-server --daemonize yes"
      invoke "sidekiq:start"
      execute "sudo service nginx restart"
    end
  end

  before :start, :make_dirs
  before :start, :services
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
  
  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart

end

