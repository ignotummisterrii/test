lock "~> 3.10.1"

# Config initial
set :repo_url, 'git@github.com:ignotummisterrii/test.git'
set :application,     'test'
set :user,            'ubuntu'
set :puma_threads,    [4, 16]
set :puma_workers,    0
set :pty,             false
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/#{fetch(:application)}"

# Puma Config 
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true 

#Sidekiq Config
set :sidekiq_default_hooks => true
set :sidekiq_pid => File.join(shared_path, 'tmp', 'pids', 'sidekiq.pid') 
set :sidekiq_env => fetch(:rack_env, fetch(:rails_env, fetch(:stage)))
set :sidekiq_log => File.join(shared_path, 'log', 'sidekiq.log')
set :sidekiq_options => nil
set :sidekiq_require => nil
set :sidekiq_tag => nil
set :sidekiq_config => nil 
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


#Rails console
set :console_role, :app # start remote console on primary server for this role
set :console_user, :ubuntu # run rails console as appuser through sudo

#Puma task
namespace :puma do
  desc 'Create Directories for Puma Pids and Socket and Log'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  desc 'Reload all services'
  task :restart_services do
    on roles(:app) do
      execute "redis-server --daemonize yes"
      invoke!("sidekiq:stop")
      invoke!("sidekiq:start")
      execute "sudo rm -f /etc/nginx/sites-enabled/default"
      invoke!("puma:nginx_config")
      execute "sudo service nginx restart"
      invoke!("puma:stop")
    end
  end

  before :start, :make_dirs
  before :start, :restart_services
  before :restart, :restart_services
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

  task :directories do
    on roles(:app) do
      execute "mkdir #{shared_path}/log -p"
      execute "sudo mkdir /etc/monit/conf.d/ -p"
    end
  end


  before :starting,     :check_revision
  before :starting,     :directories
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup



end

