require 'capistrano/ext/multistage'

set :stages, %w(staging cnc telecom)
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

    if application == "cnc"
      run "cd #{release_path}; /usr/local/rvm/gems/ree-1.8.7-2010.02/bin/bundle install"
      run "cd #{release_path}; /usr/local/rvm/rubies/ree-1.8.7-2010.02/bin/ruby script/delayed_job reload RAILS_ENV=production;"
      run "cd #{release_path}; /usr/local/rvm/gems/ree-1.8.7-2010.02/bin/rake db:migrate RAILS_ENV=production"
      run "cd #{release_path}; /usr/local/rvm/gems/ree-1.8.7-2010.02/bin/rake sitemap:refresh RAILS_ENV=production"
      run "cd #{release_path}; crontab #{release_path}/config/crontab/#{rails_env}"
      # run "cd #{release_path}; sudo chown hlx:www-data -R #{shared_path}/pids #{shared_path}/sphinx"
      # run "cd #{release_path}; /usr/local/rvm/gems/ree-1.8.7-2010.02/bin/rake ts:reindex RAILS_ENV=production"
    else
      run "cd #{release_path}; bundle install"
      run "cd #{release_path}; rake db:migrate RAILS_ENV=production"
      run "cd #{release_path}; ./script/delayed_job reload RAILS_ENV=production;"
      run "cd #{release_path}; rake ts:rebuild RAILS_ENV=production"
    end
  end

  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

before "deploy:symlink", "deploy:init_project"