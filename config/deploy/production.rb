set :application, "production"
set :deploy_to, "/home/itjob.fm/app"
set :user, "itjob.fm"

role :web, "115.238.44.110"                          # Your HTTP server, Apache/etc
role :app, "115.238.44.110"                          # This may be the same as your `Web` server
role :db,  "115.238.44.110", :primary => true        # This is where Rails migrations will run