module MailEngine
  class Engine < Rails::Engine
    initializer "mail_engine.inject_methods_to_action_mailer" do
      ActiveRecord.send(:include, MailEngine::Sendgrid)
    end

    generators do
      require 'mail_engine/generators/generator.rb'
    end
  end
end