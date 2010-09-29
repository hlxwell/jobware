set :application, "staging"
set :deploy_to, "/home/itjob.fm/app"
set :user, "itjob.fm"

role :web, "ec2.joblet.jp"
role :app, "ec2.joblet.jp"
role :db,  "ec2.joblet.jp", :primary => true