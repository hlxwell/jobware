require 'capistrano/ext/multistage'

set :stages, %w(staging production cnc)
set :default_stage, 'staging'
set :repository,  "git@github.com:anatole/jobware.git"
set :branch, ENV["BRANCH"] || "master"
set :scm, "git"
set :use_sudo, false
set :rails_env, "production"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :init_project do
    run "cd #{release_path}; cp #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "cd #{release_path}; ln -s #{shared_path}/sphinx #{release_path}/db/sphinx"
    run "cd #{release_path}; ln -s #{shared_path}/ckeditor_assets #{release_path}/public"

    if application == "cnc"
      run "cd #{release_path}; /usr/local/rvm/gems/ree-1.8.7-2010.02/bin/bundle install"
      # run "cd #{release_path}; /usr/local/rvm/rubies/ree-1.8.7-2010.02/bin/ruby script/delayed_job reload RAILS_ENV=production;"
      run "cd #{release_path}; /usr/local/rvm/gems/ree-1.8.7-2010.02/bin/rake db:migrate RAILS_ENV=production"
      run "cd #{release_path}; /usr/local/rvm/gems/ree-1.8.7-2010.02/bin/rake sitemap:refresh RAILS_ENV=production"
      run "cd #{release_path}; crontab #{release_path}/config/crontab/#{rails_env}"
      # run "cd #{release_path}; sudo chown hlx:www-data -R #{shared_path}/pids #{shared_path}/sphinx"
      # run "cd #{release_path}; /usr/local/rvm/gems/ree-1.8.7-2010.02/bin/rake ts:reindex RAILS_ENV=production"
    elsif ["production", "staging"].include?(application)
      run "cd #{release_path}; /home/large_scale/.rvm/gems/ree-1.8.7-2011.03/bin/bundle install"
      run "cd #{release_path}; /home/large_scale/.rvm/gems/ree-1.8.7-2011.03/bin/bundle exec rake db:migrate RAILS_ENV=production"
      run "cd #{release_path}; /home/large_scale/.rvm/gems/ree-1.8.7-2011.03/bin/bundle exec rake db:seed RAILS_ENV=production"
      # run "cd #{release_path}; ruby script/delayed_job reload RAILS_ENV=production"
      run "cd #{release_path}; /home/large_scale/.rvm/gems/ree-1.8.7-2011.03/bin/bundle exec rake sitemap:refresh RAILS_ENV=production"
      run "cd #{release_path}; cp #{shared_path}/sphinx/xdict #{release_path}/config/"
      # run "cd #{release_path}; rake ts:rebuild RAILS_ENV=production"
      run "cd #{release_path}; crontab #{release_path}/config/crontab/#{rails_env}"
      # run "cd #{release_path}; ./script/delayed_job restart RAILS_ENV=production"
    else
      run "cd #{release_path}; bundle install"
      run "cd #{release_path}; rake db:migrate RAILS_ENV=production"
      # run "cd #{release_path}; ./script/delayed_job restart RAILS_ENV=production"
    end
  end

  # unicorn scripts cribbed from https://github.com/daemon/capistrano-recipes/blob/master/lib/recipes/unicorn.rb
  desc "Restart unicorn"
  task :restart, :roles => :app do
    run "kill -USR2 `cat #{deploy_to}/shared/pids/unicorn.pid`" do |ch, stream, out|
      # is this block necessary?
    end
  end

  task :stop, :roles => :app do
    run "kill -QUIT `cat #{deploy_to}/shared/pids/unicorn.pid`" do |ch, stream, out|
      # is this block necessary?
    end
  end

  task :start, :roles => :app do
    run "unicorn -E #{rails_env} -D -c #{current_path}/config/unicorn.rb" do |ch, stream, out|
      # is this block necessary?
    end
  end
end

before "deploy:symlink", "deploy:init_project"
# Bluepill related tasks
after "deploy:update", "bluepill:restart"
namespace :bluepill do
  desc "Stop processes that bluepill is monitoring and quit bluepill"
  task :quit, :roles => [:app] do
    run "sudo bluepill quit"
  end

  desc "Load bluepill configuration and start it"
  task :start, :roles => [:app] do
    run "sudo bluepill load #{release_path}/config/bluepill/#{application}.pill"
  end

  task :restart, :roles => [:app] do
    # run "sudo bluepill quit"
    run "sudo bluepill load #{release_path}/config/bluepill/#{application}.pill"
  end

  desc "Prints bluepills monitored processes statuses"
  task :status, :roles => [:app] do
    run "sudo bluepill #{application} status"
  end
end

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