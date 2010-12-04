set :application, "staging"
set :deploy_to, "/home/itjob.fm/app"
set :user, "itjob.fm"
set :ssh_options, {:keys => [File.join(ENV["HOME"], "michael.pem")]}

role :web, "www.tui8.com"
role :app, "www.tui8.com"
role :db,  "www.tui8.com", :primary => true