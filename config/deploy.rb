# require 'capistrano/ext/multistage'
# set :stages, %w(staging production cnc)
# set :default_stage, 'staging'

require "bundler/capistrano"
$:.unshift(File.expand_path("./lib", ENV["rvm_path"]))
require "rvm/capistrano"
set :rvm_ruby_string, "ree"
set :rvm_type, :system

set :application, "ITJOB.FM"
set :repository,  "git@github.com:anatole/jobware.git"
set :branch, ENV["BRANCH"] || "master"
set :scm, "git"
set :keep_releases, 5
set :use_sudo, false
set :user, "app"
set :deploy_to, "/home/app/app"
set :branch, "master"
set :rails_env, "production"

role :web, "58.215.184.207"                          # Your HTTP server, Apache/etc
role :app, "58.215.184.207"                          # This may be the same as your `Web` server
role :db,  "58.215.184.207", :primary => true        # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :init_project do
    run "cd #{release_path}; cp #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "cd #{release_path}; ln -s #{shared_path}/sphinx #{release_path}/db/sphinx"
    run "cd #{release_path}; ln -s #{shared_path}/ckeditor_assets #{release_path}/public"

    run "cd #{release_path}; bundle install"
    run "cd #{release_path}; bundle exec rake sitemap:refresh RAILS_ENV=production"
    # run "cd #{release_path}; bundle exec rake db:seed RAILS_ENV=production"
    run "cd #{release_path}; crontab #{release_path}/config/crontab/#{rails_env}"
    run "cd #{release_path}; ./script/delayed_job restart RAILS_ENV=production"
    run "cd #{release_path}; sudo chown app:app -R #{shared_path}/pids #{shared_path}/sphinx"
    run "cd #{release_path}; cp #{shared_path}/sphinx/xdict #{release_path}/config/"
    run "cd #{release_path}; bundle exec rake ts:rebuild RAILS_ENV=production"
  end

  # unicorn scripts cribbed from https://github.com/daemon/capistrano-recipes/blob/master/lib/recipes/unicorn.rb
  desc "Restart passenger"
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

before "deploy:symlink", "deploy:init_project"

# Bluepill related tasks
# after "deploy:update", "bluepill:restart"
# namespace :bluepill do
#   desc "Stop processes that bluepill is monitoring and quit bluepill"
#   task :quit, :roles => [:app] do
#     run "sudo bluepill quit"
#   end
# 
#   desc "Load bluepill configuration and start it"
#   task :start, :roles => [:app] do
#     run "sudo bluepill load #{release_path}/config/bluepill/#{application}.pill"
#   end
# 
#   task :restart, :roles => [:app] do
#     # run "sudo bluepill quit"
#     run "sudo bluepill load #{release_path}/config/bluepill/#{application}.pill"
#   end
# 
#   desc "Prints bluepills monitored processes statuses"
#   task :status, :roles => [:app] do
#     run "sudo bluepill #{application} status"
#   end
# end

task :tail_log, :roles => [:app] do
  log_file = "#{shared_path}/log/production.log"
  run "tail -f #{log_file}" do |channel, stream, data|
    puts data if stream == :out
    if stream == :err
      puts "[Error: #{channel[:host]}] #{data}"
      break
    end
  end
end

# task :before_deploy
# task :after_update_code