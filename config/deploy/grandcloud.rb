set :application, "grandcloud"
set :deploy_to, "/home/app/app"
set :user, "app"

role :web, "58.215.184.207"                          # Your HTTP server, Apache/etc
role :app, "58.215.184.207"                          # This may be the same as your `Web` server
role :db,  "58.215.184.207", :primary => true        # This is where Rails migrations will run