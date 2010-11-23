safe do
  local :path => "/home/itjob.fm/backup/:kind/:id"

  s3 do
    key "1GC16GB1C78GVFV5Z1R2"
    secret "Dvuj8x5/4Wz14t22Ptsl75bxLVSZRlBcNASrDQ48"
    bucket "itjobfm_backup"
    path "backup/:kind/:id"
  end

  keep do
    local 30
    s3 15
  end

  mysqldump do
    options "-ceKq --single-transaction --create-options"
    user "root"
    password "whoafeedback"
    socket "/var/run/mysqld/mysqld.sock"
    database :jobware_production
  end

  tar do
    options "-h" # dereference symlinks

    archive "itjob-fm" do
      files "/home/itjob.fm/app/shared"
      exclude ["/home/itjob.fm/app/shared/log", "/home/itjob.fm/app/shared/pids", "/home/itjob.fm/app/shared/sphinx"]
    end
  end
end