safe do
  local :path => "/home/itjob.fm/backup/:kind/:id"

  s3 do
    key "AKIAIM4DOXXND43IZSUA"
    secret "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"
    bucket "itjob.fm"
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