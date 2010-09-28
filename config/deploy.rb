# require 'capistrano/ext/multistage'

set :application, "jobware"
set :repository,  "git@github.com:anatole/jobware.git"
set :branch, ENV["BRANCH"] || "master"
set :deploy_to, "/home/hlx/www/jobware/"
set :user, "hlx"
set :use_sudo, false
set :rails_env, "production"
set :scm, "git"

role :web, "bbs.hzva.org"                          # Your HTTP server, Apache/etc
role :app, "bbs.hzva.org"                          # This may be the same as your `Web` server
role :db,  "bbs.hzva.org", :primary => true        # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :init_project do
    run "cd #{release_path}; /home/hlx/.rvm/gems/ree-1.8.7-2010.01/bin/bundle install"
    run "cd #{release_path}; ln -s #{shared_path}/sphinx #{release_path}/db/sphinx"
    run "cd #{release_path}; ./script/delayed_job reload;"
    # run "cd #{release_path}; crontab #{release_path}/config/crontab/#{rails_env}"
    # run "cd #{release_path}; /home/hlx/.rvm/gems/ree-1.8.7-2010.01/bin/rake db:migrate RAILS_ENV=production"
  end

  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

before "deploy:symlink", "deploy:init_project"