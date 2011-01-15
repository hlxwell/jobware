module MailEngine
  class CopyMigration < Rails::Generators::Base
    desc "Add mail template model migration to your application."

    def self.source_root
      @_source_root ||= File.join(File.dirname(__FILE__))
    end

    def copy_migrations
      from = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "db", "migrate", "20110114030841_create_table_mail_template.rb"))
      to = File.expand_path(File.join(Rails.root, "db", "migrate", "20110114030841_create_table_mail_template.rb"))
      copy_file from, to
    end
  end # CopyMigration
end # MailEngine