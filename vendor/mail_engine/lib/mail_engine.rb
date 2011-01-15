require 'active_support'
require 'mail_engine/engine'

module MailEngine
  extend ::ActiveSupport::Autoload

  autoload :Sendgrid
  autoload :Mailer
end