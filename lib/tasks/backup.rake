namespace :backup do

  desc "database backup"
  task :database, [:prefix] do |t, args|
    datetime = Time.now.strftime("%Y%m%d")

    db_config = YAML.load_file(File.join(Rails.root, 'config', 'database.yml'))[Rails.env]
    db_username = db_config["username"]
    db_password = db_config["password"]
    db_database = db_config["database"]
    db_socket   = db_config["socket"]

    if args[:prefix].blank?
      backup_file_path = "~/database_backup/#{db_database}_#{datetime}.sql"
    else
      backup_file_path = "~/database_backup/#{args[:prefix]}_#{db_database}_#{datetime}.sql"
    end
    # backup_tar_file_path = "~/database_backup/#{db_database}_#{datetime}.tar.gz"

    system "mkdir -p ~/database_backup"
    # system "mysqldump -u #{db_username} -p'#{db_password}' #{db_database} > #{backup_file_path}"
    system "mysqldump -u #{db_username} -S #{db_socket} -p'#{db_password}' #{db_database} > #{backup_file_path}"
  end

end
