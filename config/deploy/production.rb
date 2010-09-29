set :application, "production"
set :deploy_to, "/home/hlx/www/jobware/"
set :user, "hlx"

role :web, "211.138.113.63"                          # Your HTTP server, Apache/etc
role :app, "211.138.113.63"                          # This may be the same as your `Web` server
role :db,  "211.138.113.63", :primary => true        # This is where Rails migrations will run