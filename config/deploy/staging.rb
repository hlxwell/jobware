# -*- encoding : utf-8 -*-
set :application, "staging"
set :deploy_to, "/home/itjob.fm/app"
set :user, "itjob.fm"
# set :ssh_options, {:keys => [File.join(ENV["HOME"], "michael.pem")]}

role :web, "175.41.187.67"
role :app, "175.41.187.67"
role :db,  "175.41.187.67", :primary => true
