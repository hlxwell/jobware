Typus.setup do |config|

  # Application name.
  config.admin_title = "ITJob.FM"
  config.admin_sub_title = "全国最大的IT招聘网站"

  # Configure the e-mail address which will be shown in Admin::Mailer.
  # When this option is define Typus will allow admin users to recover
  # lost passwords.
  config.mailer_sender = "hlxwell@gmail.com"

  # Define file attachment settings.
  # config.file_preview = :typus_preview
  # config.file_thumbnail = :typus_thumbnail

  # Authentication: :none, :http_basic
  config.authentication = :session

  # Define username and password for http authentication
  # config.username = "admin"
  # config.password = "columbia"

  # Define available languages on the admin interface.
  # config.available_locales = [:en]


  # Define the default root.
  # config.master_role = "admin"

  # Define relationship table.
  # config.relationship = "typus_users"

  # Define user_class_name and user_fk.
  config.user_class_name = "AdminUser"

  # Define the user_fk
  # config.user_fk = "admin_user_id"
end
