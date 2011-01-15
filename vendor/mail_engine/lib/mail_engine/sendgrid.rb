module MailEngine
  module Sendgrid
    extend ActiveSupport::Autoload

    autoload :Methods
    autoload :SmtpApi
  end
end