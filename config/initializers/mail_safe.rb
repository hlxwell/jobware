if defined?(MailSafe::Config) and Rails.env == 'development'
  MailSafe::Config.internal_address_definition = /.*/i
  MailSafe::Config.replacement_address = 'hlxwell@gmail.com'
end