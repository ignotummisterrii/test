# Load DSL and set up stages
require "capistrano/setup"

require "capistrano/deploy"
require "capistrano/scm/git"
require 'capistrano/bundler' 
require 'capistrano/local_precompile'
require 'capistrano/rails/migrations'
require 'capistrano/rvm'
require 'capistrano/puma'
require 'capistrano/sidekiq'
require 'capistrano/sidekiq/monit' 
require 'capistrano/rails/console'

install_plugin Capistrano::SCM::Git
install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Nginx  
 

# Include tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails
#   https://github.com/capistrano/passenger
#
# require "capistrano/rvm"
# require "capistrano/rbenv"
# require "capistrano/chruby"
# require "capistrano/bundler"
# require "capistrano/rails/assets"
# require "capistrano/rails/migrations"
# require "capistrano/passenger"

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
