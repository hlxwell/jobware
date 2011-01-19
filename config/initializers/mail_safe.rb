if defined?(MailSafe::Config) and Rails.env == 'development'
  MailSafe::Config.internal_address_definition = /.*/i
  MailSafe::Config.replacement_address = 'hlxwell@gmail.com'
else
  MailSafe::Config.internal_address_definition = /itjob.fm.*@gmail\.com/i
  MailSafe::Config.replacement_address = 'hlxwell@gmail.com'
end